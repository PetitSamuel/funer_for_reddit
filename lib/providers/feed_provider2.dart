import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/secret/secret.dart';
import 'package:funer_for_reddit/shared/requests_shared.dart';

class FeedProvider2 with ChangeNotifier {
  bool isLoading = false;
  String subreddit = "";
  String sort = "hot";
  String after = "";
  String postsTimeframe = "";
  List<PostModel> posts;
  FeedProvider2() {
    this.posts = new List();
  }

  loading() {
    isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  updateSort(String newSort) {
    if(this.sort == newSort) {
      print("tried to change sort to what it already was");
      // todo: maybe handle this better
      return;
    }
    this.sort = newSort;
    notifyListeners();
  }

  setTimeframe(String time) {
    this.postsTimeframe = time;
    notifyListeners();
  }

  Future<bool> getPostsSignedIn(String sub, String access) async {
    loading();
    this.subreddit = sub;
    this.posts.clear();
    // make sure to update storage data

    String url = urlBuilder("${this.subreddit}" +
        "${this.sort}/?limit=15&t=${this.postsTimeframe}");
    print(url);
    var response = await buildRequestAndGet(url, accessToken: access);

    if (response.statusCode != 200) {
      // error occured, return null
      return null;
    }
    handlePostsResponse(json.decode(response.body));
    this.stopLoading();
    return true;
  }

  Future<bool> loadMorePostsSignedIn(String access) async {
    if(this.after == null || this.after.isEmpty) {
      print("error when trying to load more posts : after code is empty"); 
      return false;
    }
    loading();
    String url = urlBuilder("${this.subreddit}" +
        "${this.sort}/?limit=15&after=${this.after}&t=${this.postsTimeframe}");
    print(url);
    var response = await buildRequestAndGet(url, accessToken: access);

    if (response.statusCode != 200) {
      // error occured, return null
      return null;
    }
    handlePostsResponse(json.decode(response.body));
    this.stopLoading();
    return true;
  }

  Future<bool> getPostsUnauth(String sub) async {
    loading();
    this.subreddit = sub;
    this.posts.clear(); 
    String url = nonOauthUrlBuilder(
        "${this.subreddit}" + "${this.sort}.json?limit=15");
    var response = await buildRequestAndGet(url, headers: {
      'User-Agent': USER_AGENT,
    });
    if (response.statusCode != 200) {
      // error occured, return null
      return null;
    }
    handlePostsResponse(json.decode(response.body));
    stopLoading();
    return true;
  }

  Future<bool> loadMorePostsUnauth() async {
    loading();
    String url = nonOauthUrlBuilder(
        "${this.subreddit}" + "${this.sort}.json?limit=15&after=${this.after}");
    var response = await buildRequestAndGet(url, headers: {
      'User-Agent': USER_AGENT,
    });
    if (response.statusCode != 200) {
      // error occured, return null
      return null;
    }
    handlePostsResponse(json.decode(response.body));
    stopLoading();
    return true;
  }

  handlePostsResponse(Map<String, dynamic> response) {
    if(response == null) {
      print("an error occure : tried to parse null feed response.");
      return;
    }
    response['data']['children'].map((e) {
      PostModel post = PostModel.fromJson(e['data']);
      if(post != null) this.posts.add(post);
    });
    this.after = response['data']['after'] ?? "";
  }
}
