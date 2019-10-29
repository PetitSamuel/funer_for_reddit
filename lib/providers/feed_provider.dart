import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/helpers/secure_storage_helper.dart';
import 'package:funer_for_reddit/models/post_model.dart';
import 'package:funer_for_reddit/parsers/single_post_parser.dart';
import 'package:funer_for_reddit/secret/secret.dart';

import 'package:funer_for_reddit/shared/requests.dart';

class FeedProvider with ChangeNotifier {
  bool _isLoading = false;
  String subreddit = "";
  String sort = "hot";
  List<SinglePostModel> posts;

  FeedProvider() {
    posts = new List();
    fetchPostsListing();
  }

  final SecureStorageHelper storage = new SecureStorageHelper();

  bool get signedIn => storage.signInStatus;
  bool get isLoading => _isLoading;

  setSort(String s) {
    this.sort = s;
  }

  Future<Map<String, dynamic>> loadSignedInPosts() async {
    String token = await storage.accessToken;
    String url = urlBuilder("${this.subreddit}" + "${this.sort}/");
    var response = await buildRequestAndGet(url, accessToken: token);
    if (response.statusCode != 200) {
      // error occured, return null
      return null;
    }
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> loadUnauthentificatedPosts() async {
    String url = urlBuilder("${this.subreddit}" + "${this.sort}/.json");
    var response = await buildRequestAndGet(url, headers: {
      'User-Agent': USER_AGENT,
    });
    if (response.statusCode != 200) {
      // error occured, return null
      return null;
    }
    return json.decode(response.body);
  }

  Future<void> fetchPostsListing({String sub = ""}) async {
    loading();
    this.posts.clear();
    if (sub.isNotEmpty) {
      this.subreddit = sub.toLowerCase();
    }

    this.sort = sort.toLowerCase();

    // make sure to update storage data
    await this.storage.init();

    Map<String, dynamic> response = this.signedIn
        ? await loadSignedInPosts()
        : await loadUnauthentificatedPosts();
    if (response == null) {
      print("error in call");
      return;
    }
    var p = response['data']['children'].map((e) {
      return singlePostInstanceFromJson(e['data']);
    }).toList();

    p.forEach((x) => this.posts.add(x));
    this.stopLoading();
  }

  loading() {
    _isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
