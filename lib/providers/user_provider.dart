import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/helpers/secure_storage_helper.dart';
import 'package:funer_for_reddit/models/subreddit_models/subscribed_subreddit_model.dart';
import 'package:funer_for_reddit/models/user_models/user_information_model.dart';

import 'package:funer_for_reddit/shared/requests.dart';

class UserProvider with ChangeNotifier {
  UserInformationModel user;
  List<SubscribedSubredditModel> subreddits;
  bool _isLoading = false;
  String after = "";
  UserProvider() {
    subreddits = new List();
    loadUserInformation();
  }

  final SecureStorageHelper storage = new SecureStorageHelper();

  bool get signedIn => storage.signInStatus;
  bool get isLoading => _isLoading;
  List<SubscribedSubredditModel> get subscribedSubReddits {
    return this.subreddits;
  }

  bool get isMissingData {
    return user == null ||
        user.iconImg == null ||
        user.iconImg.isEmpty ||
        user.name == null ||
        user.name.isEmpty;
  }

  Future<void> handleGetMe() async {
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
    String url =
        urlBuilder("subreddits/mine/subscriber/?limit=100&after=${this.after}");
    String accessToken = await storage.accessToken;
    if (accessToken == null || accessToken.isEmpty) return;
    final response = await buildRequestAndGet(url, accessToken: accessToken);

    if (response.statusCode != 200) {
      // an error occured, show error message  & return
      return;
    }
    Map<String, dynamic> subRedditMap = json.decode(response.body);
    List subsList = subRedditMap['data']['children'].map((e) {
      return SubscribedSubredditModel.fromJson(e['data']);
    }).toList();

    for (SubscribedSubredditModel x in subsList) {
      this.subreddits.add(x);
    }
    this.subreddits.sort((a, b) =>
        a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()));
    this.after = subRedditMap['data']['after'] ?? "";
  }

  Future<void> loadUserInformation() async {
    loading();
    await handleGetMe();
    await handleGetUserSubreddits();
    stopLoading();

    while (this.after != "") {
      // todo: indicate loading status here in the drawer
      await handleGetUserSubreddits();
      notifyListeners();
    }
  }

  clearData() {
    this.user = null;
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
