import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/shared/secure_storage_shared.dart';
import 'package:funer_for_reddit/models/subreddit_models/subscribed_subreddit_model.dart';
import 'package:funer_for_reddit/models/user_models/user_information_model.dart';
import 'package:funer_for_reddit/shared/requests_shared.dart';

class UserProvider with ChangeNotifier {
  UserInformationModel user;
  List<SubredditModel> subreddits;
  bool _isLoading = false;
  bool _isLoadingSubs = false;
  String after = "";
  UserProvider() {
    loadUserInformation();
  }

  final SecureStorageShared storage = new SecureStorageShared();

  bool get signedIn => storage.signInStatus;
  bool get isLoading => _isLoading;
  bool get isLoadingSubreddits => _isLoadingSubs;
  bool get hasSubredditsToDisplay =>
      this.subreddits != null && this.subreddits.length == 0;
  List<SubredditModel> get subscribedSubReddits {
    if (this.subreddits == null) return [];
    return this.subreddits;
  }

  SubredditModel currentSubreddit(String sub) {
    return this
        .subscribedSubReddits
        .firstWhere((val) => val.displayName == sub, orElse: null);
  }

  bool get isMissingData {
    return user == null ||
        user.iconImg == null ||
        user.iconImg.isEmpty ||
        user.name == null ||
        user.name.isEmpty;
  }

  Future<void> handleGetMe() async {
    if (this.after == "") {
      this.subreddits = new List();
    }
    String url = urlBuilder("/me", isApiV1: true);
    String accessToken = await storage.accessToken;
    if (accessToken == null || accessToken.isEmpty) return;
    final response = await buildRequestAndGet(url, accessToken: accessToken);

    if (response.statusCode != 200) {
      // an error occured, show error message  & return
      print("error when loading user info");
      return;
    }
    user = UserInformationModel.fromJson(json.decode(response.body));
  }

  Future<void> handleGetUserSubreddits() async {
    _isLoadingSubs = true;
    notifyListeners();
    String url =
        urlBuilder("subreddits/mine/subscriber/?limit=50&after=${this.after}");
    String accessToken = await storage.accessToken;
    if (accessToken == null || accessToken.isEmpty) return;
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

  Future<void> loadUserInformation() async {
    loading();
    await handleGetMe();
    stopLoading();
    await handleGetUserSubreddits();

    while (this.after != "") {
      // todo: indicate loading status here in the drawer
      await handleGetUserSubreddits();
      notifyListeners();
    }
  }

  clearData() {
    this.user = null;
    this.subreddits = new List();
    this.notifyListeners();
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
