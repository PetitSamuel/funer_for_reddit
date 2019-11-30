import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/subreddit_models/subscribed_subreddit_model.dart';
import 'package:funer_for_reddit/models/user_models/user_information_model.dart';
import 'package:funer_for_reddit/shared/requests_shared.dart';

class UserProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isLoadingSubs = false;
  bool _isLoadingUser = false;
  String after = "";
  List<SubredditModel> subreddits;
  UserInformationModel user;

  bool get loading => _isLoading;
  bool get loadingUser => _isLoadingUser;
  bool get loadingSubs => _isLoadingSubs;
  
  UserProvider() {
  }

  Future<void> handleGetMe(String accessToken) async {
    _isLoadingUser = true;
    notifyListeners();

    String url = urlBuilder("/me", isApiV1: true);
    if (accessToken == null || accessToken.isEmpty) {
      //todo : log it
      print("empty access token given");
      return;
    }
    final response = await buildRequestAndGet(url, accessToken: accessToken);

    if (response.statusCode != 200) {
      // an error occured, show error message  & return
      print("error when loading user info");
      return;
    }
    user = UserInformationModel.fromJson(json.decode(response.body));

    _isLoadingUser = false;
    notifyListeners();
  }

  Future<void> handleGetUserSubreddits(String accessToken) async {
    if (this.after == "") {
      this.subreddits = new List();
    }
    _isLoadingSubs = true;
    notifyListeners();
    String url =
        urlBuilder("subreddits/mine/subscriber/?limit=50&after=${this.after}");
    if (accessToken == null || accessToken.isEmpty) {
      //todo : log this 
      print("get user subreddits given empty access token");
      return;
    }
    final response = await buildRequestAndGet(url, accessToken: accessToken);
    if (response.statusCode != 200) {
      // an error occured, show error message  & return
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
