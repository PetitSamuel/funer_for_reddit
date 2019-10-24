import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/helpers/secure_storage_helper.dart';
import 'package:funer_for_reddit/models/Subreddit.dart';
import 'package:funer_for_reddit/models/User.dart';
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
    return user.icon_img == null ||
        user.icon_img.isEmpty ||
        user.display_name_prefixed == null ||
        user.display_name_prefixed.isEmpty;
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
      e = e['data'];
      String iconUrl = e['icon_img'] ?? "";
      if (iconUrl.isEmpty) {
        iconUrl = e['community_icon'] ?? "";
      }
      if (iconUrl.isEmpty) {
        iconUrl = e['header_img'] ?? "";
      }

      return (new Subreddit(
          display_name: e['display_name'],
          header_img: e['header_img'],
          display_name_prefixed: e['display_name_prefixed'],
          subscribers: e['subscribers'].toString(),
          community_icon: iconUrl,
          user_is_subscriber: e['user_is_subscriber'].toString(),
          url: e['url']));
    }).toList();

    if (user == null) user = new UserInformation();
    user.subredditsList = new List();
    for (Subreddit x in subsList) {
      user.subredditsList.add(x);
    }
  }

  Future<void> loadUserInformation() async {
    loading();
    await handleGetMe();
    await handleGetUserSubreddits();
    stopLoading();
  }

  clearData() {
    this.user = null;
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
