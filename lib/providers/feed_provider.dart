import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/secret/secret.dart';
import 'package:funer_for_reddit/shared/requests_shared.dart';

class FeedProvider with ChangeNotifier {
  bool _isLoading = false;
  String subreddit = "";
  String sort = "hot";
  String after = "";
  String timeframe = "";
  List<PostModel> posts;
  bool clearOnFetch = false;

  bool get loading => _isLoading;
  bool get showTimeOption => this.sort == 'top' || this.sort == 'controversial';

  FeedProvider() {
    posts = new List();
  }

  setSort(String s) {
    this.sort = s.toLowerCase();
    this.clearOnFetch = true;
    if (this.sort == 'top' || this.sort == 'controversial') {
      this.timeframe = "day";
    } else {
      this.timeframe = "";
    }
    notifyListeners();
  }

  setTimeframe(String time) {
    this.timeframe = time;
    this.clearOnFetch = true;
    notifyListeners();
  }

  Future<Map<String, dynamic>> loadSignedInPosts(String token) async {
    print(this.timeframe);
    String url = urlBuilder("${this.subreddit}" +
        "${this.sort}/?limit=50&after=${this.after}&t=${this.timeframe}");
    print(url);
    var response = await buildRequestAndGet(url, accessToken: token);
    if (response.statusCode != 200) {
      // error occured, return null
      return null;
    }
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> loadUnauthentificatedPosts() async {
    print("unauth");
    String url = nonOauthUrlBuilder(
        "${this.subreddit}" + "${this.sort}.json?limit=50&after=${this.after}");
    var response = await buildRequestAndGet(url, headers: {
      'User-Agent': USER_AGENT,
    });
    if (response.statusCode != 200) {
      // error occured, return null
      print("null!");
      return null;
    }
    return json.decode(response.body);
  }

  Future<void> fetchPostsListing(String sub, {String accessToken = ""}) async {
    startLoading();
    this.subreddit = sub.toLowerCase();
    this.posts.clear();
    this.after = "";

    Map<String, dynamic> response = accessToken.isNotEmpty
        ? await loadSignedInPosts(accessToken)
        : await loadUnauthentificatedPosts();

    if (response == null) {
      print("null response when loading posts");
      stopLoading();
      return;
    }

    var p = response['data']['children'].map((e) {
      return PostModel.fromJson(e['data']);
    }).toList();
    p.forEach((x) => this.posts.add(x));
    this.after = response['data']['after'] ?? "";
    this.stopLoading();
  }

  updateLikes(PostModel p, bool newLikes, int diff) {
    PostModel post =
        this.posts.firstWhere((curr) => curr.id == p.id, orElse: () => null);
    if (post == null) {
      print("error : could not find post to upvote");
      return;
    }
    post.ups += diff;
    post.likes = newLikes;
  }

  startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
