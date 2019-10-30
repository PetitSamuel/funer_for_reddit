import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/helpers/secure_storage_helper.dart';
import 'package:funer_for_reddit/models/subreddit_model.dart';
import 'package:funer_for_reddit/models/user_information_model.dart';
import 'package:funer_for_reddit/parsers/user_information_parser.dart';

import 'package:funer_for_reddit/shared/requests.dart';

class UserProvider with ChangeNotifier {
  UserInformation user;
  bool _isLoading = false;

  UserProvider() {
    loadUserInformation();
  }

  final SecureStorageHelper storage = new SecureStorageHelper();

  bool get signedIn => storage.signInStatus;
  bool get isLoading => _isLoading;
  List<Subreddit> get subscribedSubReddits {
    if (user == null || user.subredditsList == null) {
      return [];
    }
    return user.subredditsList;
  }

  bool get isMissingData {
    return user == null ||
        user.iconImg == null ||
        user.iconImg.isEmpty ||
        user.displayNamePrefixed == null ||
        user.displayNamePrefixed.isEmpty;
  }

  Future<void> handleGetMe() async {
    String url = urlBuilder("/me", isApiV1: true);
    String accessToken = await storage.accessToken;
    if (accessToken == null || accessToken.isEmpty) return;
    final response = await buildRequestAndGet(url, accessToken: accessToken);

    if (response.statusCode != 200) {
      // an error occured, show error message  & return
      return;
    }
    user = parseFromMeResponse(json.decode(response.body));
  }

  Future<void> handleGetUserSubreddits() async {
    String url = urlBuilder("subreddits/mine/subscriber/?limit=100");
    String accessToken = await storage.accessToken;
    if (accessToken == null || accessToken.isEmpty) return;
    final response = await buildRequestAndGet(url, accessToken: accessToken);

    if (response.statusCode != 200) {
      // an error occured, show error message  & return
      return;
    }
    Map<String, dynamic> subRedditMap = json.decode(response.body);
    List subsList = subRedditMap['data']['children'].map((e) {
      return subredditFromSubscriptions(e['data']);
    }).toList();

    if (user == null) user = new UserInformation();
    user.subredditsList = new List();
    for (Subreddit x in subsList) {
      user.subredditsList.add(x);
    }
    user.subredditsList.sort((a, b) =>
        a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()));
  }

  Future<void> loadUserInformation() async {
    loading();
    await handleGetMe();
    await handleGetUserSubreddits();
    stopLoading();
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
