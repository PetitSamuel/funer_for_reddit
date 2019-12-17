import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/models_export.dart';
import 'package:funer_for_reddit/shared/requests_shared.dart';

class UserProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isLoadingSubs = false;
  bool _isLoadingUser = false;
  String after = "";
  List<SubredditModel> subreddits = new List();
  UserInformationModel user;

  bool get loading => _isLoading;
  bool get loadingUser => _isLoadingUser;
  bool get loadingSubs => _isLoadingSubs;
  bool get hasUser => user != null;
  bool get hasSubs => subreddits != null && subreddits.length != 0;

  UserProvider();

  clearStorage() {
    this.subreddits = new List();
    this.user = null;
    this.after = "";
  }

  getSub(String sub) {
    String s = sub.substring(0, sub.length - 1);
    SubredditModel subreddit = this.subreddits.firstWhere(
        (test) => test.displayNamePrefixed == s,
        orElse: () => null);

    if (subreddit == null) {
      // todo : fetch from api
      return null;
    }

    return subreddit;
  }

  Future<void> handleGetMe(String accessToken) async {
    _isLoadingUser = true;
    notifyListeners();

    String url = urlBuilder("/me", isApiV1: true);
    if (accessToken == null || accessToken.isEmpty) {
      //todo : log it
      print("empty access token given");
      _isLoadingUser = false;
      notifyListeners();
      return;
    }
    final response = await buildRequestAndGet(url, accessToken: accessToken);

    if (response.statusCode != 200) {
      // an error occured, show error message  & return
      print("error when loading user info");
      _isLoadingUser = false;
      notifyListeners();
      return;
    }
    user = UserInformationModel.fromJson(json.decode(response.body));
    _isLoadingUser = false;
    notifyListeners();
  }

  // Method which keeps loading user subreddits as long as there are more to load.
  Future<void> getUserSubreddits(String accessToken) async {
    await handleGetUserSubreddits(accessToken);
    while (this.after != "") {
      await handleGetUserSubreddits(accessToken);
    }
  }

  Future<void> handleGetUserSubreddits(String accessToken) async {
    if (this.after == "") {
      this.subreddits = new List();
    }
    _isLoadingSubs = true;
    notifyListeners();
    if (accessToken == null || accessToken.isEmpty) {
      //todo : log this
      print("get user subreddits given empty access token");
      return;
    }
    String url =
        urlBuilder("subreddits/mine/subscriber/?limit=50&after=${this.after}");
    final response = await buildRequestAndGet(url, accessToken: accessToken);
    if (response.statusCode != 200) {
      // todo : an error occured, show error message  & return handle this
      print("status code when loading subs was not 200");
      return;
    }
    Map<String, dynamic> subRedditMap = json.decode(response.body);
    List subsList = subRedditMap['data']['children'].map((e) {
      return SubredditModel.fromJson(e['data']);
    }).toList();

    for (SubredditModel x in subsList) {
      this.subreddits.add(x);
    }
    this.subreddits.sort((a, b) =>
        a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()));
    this.after = subRedditMap['data']['after'] ?? "";
    _isLoadingSubs = false;
    notifyListeners();
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
