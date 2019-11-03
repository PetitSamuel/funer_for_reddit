import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/helpers/secure_storage_helper.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/secret/secret.dart';
import 'package:funer_for_reddit/shared/constants.dart';

import 'package:funer_for_reddit/shared/requests.dart';

class FeedProvider with ChangeNotifier {
  bool _isLoading = false;
  bool isVoteLoading = false;
  String subreddit = "";
  String sort = "hot";
  String after = "";
  String timeframe = "";
  bool clearOnReload = false;
  List<SinglePostModel> posts;

  FeedProvider() {
    posts = new List();
    fetchPostsListing();
  }

  final SecureStorageHelper storage = new SecureStorageHelper();

  bool get signedIn => storage.signInStatus;
  bool get isLoading => _isLoading;
  bool get showTimeOption => this.sort == 'top' || this.sort == 'controversial';

  setSort(String s) {
    this.sort = s;
    this.clearOnReload = true;
    if (this.sort == 'top' || this.sort == 'controversial') {
      this.timeframe = "day";
    } else {
      this.timeframe = "";
    }
    notifyListeners();
  }

  setSubredditAndFetchWithClear(String sub) {
    this.subreddit = sub;
    this.clearOnReload = true;
    this.fetchPostsListing();
    notifyListeners();
  }

  setTimeframe(String time) {
    this.timeframe = time;
    this.clearOnReload = true;
    notifyListeners();
  }

  updateWithClearOnReload() {
    this.clearOnReload = true;
    this.fetchPostsListing();
  }

  Future<Map<String, dynamic>> loadSignedInPosts() async {
    print(this.timeframe);
    print("hey");
    String token = await storage.accessToken;
    String url = urlBuilder("${this.subreddit}" +
        "${this.sort}/?limit=15&after=${this.after}&t=${this.timeframe}");
    print(url);
    var response = await buildRequestAndGet(url, accessToken: token);
    if (response.statusCode != 200) {
      // error occured, return null
      return null;
    }
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> loadUnauthentificatedPosts() async {
    String url = nonOauthUrlBuilder(
        "${this.subreddit}" + "${this.sort}.json?limit=15&after=${this.after}");
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
    if (sub.isNotEmpty) {
      this.subreddit = sub.toLowerCase();
      this.clearOnReload = true;
    }
    this.sort = sort.toLowerCase();

    if (this.clearOnReload) {
      this.clearOnReload = false;
      this.posts.clear();
      this.after = "";
    }
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
      return SinglePostModel.fromJson(e['data']);
    }).toList();
    p.forEach((x) => this.posts.add(x));
    this.after = response['data']['after'] ?? "";
    this.stopLoading();
  }

  Future<bool> votePost(String post, String type, bool likes) async {
    if (!this.signedIn) {
      // not logged in!
      // todo : show error message
      return false;
    }
    this.isVoteLoading = true;
    notifyListeners();

    int dir = 0;
    int upsChange = 0;
    if (type == "up" && likes == true) {
      upsChange -= 1;
    } else if (type == "up" && likes == false) {
      dir = UPVOTE_DIR;
      upsChange += 2;
    } else if (type == "up") {
      dir = UPVOTE_DIR;
      upsChange += 1;
    } else if (type == "down" && likes == true) {
      dir = DOWNVOTE_DIR;
      upsChange -= 2;
    } else if (type == "down" && likes == false) {
      upsChange += 1;
    } else {
      upsChange -= 1;
      dir = DOWNVOTE_DIR;
    }

    String access = await storage.accessToken;
    String url = urlBuilder("api/vote");
    dynamic body = "id=$post&dir=$dir&api_type=json";

    var response = await buildRequestAndPost(url,
        body: body, headers: buildPostHeadersFromToken(access));

    if (response.statusCode != 200) {
      print("here");
      // TODO : handle error message
      return false;
    }

    SinglePostModel item = this.posts.singleWhere((item) => item.name == post);
    if (dir == UPVOTE_DIR) {
      item.likes = true;
    } else if (dir == DOWNVOTE_DIR) {
      item.likes = false;
    } else {
      item.likes = null;
    }
    item.ups += upsChange;

    this.isVoteLoading = false;
    notifyListeners();
    return true;
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
