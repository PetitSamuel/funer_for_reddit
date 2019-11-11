import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:funer_for_reddit/authentification/auth_webview.dart';
import 'package:funer_for_reddit/helpers/date_time_helper_functions.dart';
import 'package:funer_for_reddit/secret/secret.dart';
import 'package:funer_for_reddit/authentification/local_server.dart';
import 'package:funer_for_reddit/shared/requests_shared.dart';

class AuthentificatorProvider2 with ChangeNotifier {
  bool signedIn = false;
  bool isLoading = false;
  FlutterSecureStorage storage;
  Map<String, dynamic> storageMap;

  Future<String> get accessToken async {
    if (needsTokenRefresh() && this.signedIn) {
      await performTokenRefresh();
    }
    return this.storageMap['accessToken'] ?? "";
  }
    String get lastTokenRefresh {
    return this.storageMap['lastTokenRefresh'] ?? "";
  }

  String get refreshToken => this.storageMap['refreshToken'] ?? "";

  AuthentificatorProvider2() {
    this.storage = new FlutterSecureStorage();
    validateAuth();
  }

  loading() {
    isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  updateStorageMap() async {
    this.storageMap = await this.storage.readAll();
  }

  Future<bool> validateAuth() async {
    loading();
    await updateStorageMap();
    this.signedIn = (this.storageMap['signedIn'] ?? "") == "true";
    if(this.refreshToken.isEmpty) {
      this.signedIn = false;
      this.storage.deleteAll();
    }
    stopLoading();
    return this.signedIn;
  }

  Future<bool> authenticateUser(BuildContext context) async {
    loading();
    // listen to localhost requests
    final LocalServer localServer = LocalServer();
    Stream<String> codeStream = await localServer.server();

    // todo : add token here to track users are the same before & after
    final String webviewUrl = authUrlBuilder(
        "authorize.compact?client_id=$CLIENT_ID&response_type=code&state=GENERATESOMETHINGHERE&redirect_uri=$REDIRECT_URL&duration=permanent&scope=identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread");

    // launch webview
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthWebview(url: webviewUrl),
        ));

    // server returns the first access_code it receives
    final String accessCode = await codeStream.first ?? "";

    // todo: show an error message here
    // error during login (no access code provided).
    if (accessCode.isEmpty) return false;

    String url = authUrlBuilder("/access_token");
    dynamic body =
        "grant_type=authorization_code&code=$accessCode&redirect_uri=$REDIRECT_URL";
    final response =
        await buildRequestAndPost(url, body: body, useAuthHeaders: true);

    // user has accepted or declined. Close webview
    Navigator.pop(context);
    if (response.statusCode != 200) {
      // todo: show error message
      signedIn = false;
      stopLoading();
      return false;
    }

    Map<String, dynamic> map = json.decode(response.body);
    String _accessToken = map['access_token'];
    String _refreshToken = map["refresh_token"];

    if ((_accessToken ?? "").isEmpty || (_refreshToken ?? "").isEmpty) {
      // todo: show error message
      this.signedIn = false;
      stopLoading();
      return false;
    }

    signedIn = true;
    await this.storage.write(key: "accessToken", value: _accessToken);
    await this.storage.write(key: "refreshToken", value: _refreshToken);
    await this.storage.write(key: "signedIn", value: signedIn.toString());
    await this.storage.write(
      key: "lastTokenRefresh",
      value: getDateAsString(),
    );
    await updateStorageMap();
    stopLoading();
    return true;
  }

  bool needsTokenRefresh() {
    if (this.lastTokenRefresh.isEmpty) {
      return true;
    }
    Duration time = (DateTime.now()).difference(DateTime.parse(this.lastTokenRefresh));
    print(time.toString());
    return time.inMinutes > 50;
  }

  Future<bool> performTokenRefresh() async {
    if(this.signedIn && this.refreshToken.isNotEmpty) {
      print("tried to refresh token but not signed in and/or refresh token is empty.");
      return false;
    }
    String url = authUrlBuilder("access_token");
    dynamic body = "grant_type=refresh_token&refresh_token=${this.refreshToken}";
    final response =
        await buildRequestAndPost(url, body: body, useAuthHeaders: true);
    if (response.statusCode != 200) {
      // Show error : failed to load token
      // todo: handle error here
      print("failed when refreshing access token");
      return false;
    }
    Map<String, dynamic> map = json.decode(response.body);
    String _accessToken = map['access_token'];
    print(_accessToken);
    if(_accessToken == null || _accessToken.isEmpty) {
      print("access token from response is null or empty. Tried to refresh access.");
      return false;
    }
    await this.storage.write(key: "accessToken", value: _accessToken);
    await this.storage.write(
      key: "lastTokenRefresh",
      value: getDateAsString(),
    );
    await updateStorageMap();
    return true;
  }

  Future<void> signOutUser() async {
    print("signing out!!");
    loading();
    // todo : delete token through API.
    await storage.deleteAll();
    this.storageMap.clear();
    signedIn = false;
    stopLoading();
  }
}
