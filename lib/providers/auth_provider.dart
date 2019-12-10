import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funer_for_reddit/authentification/auth_webview.dart';
import 'package:funer_for_reddit/authentification/local_server.dart';
import 'package:funer_for_reddit/secret/secret.dart';
import 'package:funer_for_reddit/shared/dates_shared.dart';
import 'package:funer_for_reddit/shared/requests_shared.dart';

class AuthProvider with ChangeNotifier {
  bool _signedIn = false;
  bool _isLoading = false;
  String _accessToken = "";
  String _refreshToken = "";
  final storage = new FlutterSecureStorage();
  Map<String, String> map;

  bool get signedIn {
    if (map == null) return false;
    return (map['signed_in'] ?? "") == "true";
  }

  Future<bool> get signedInAsync async {
    return (await this.storage.read(key: 'signed_in') ?? "") == "true";
  }

  Future<String> get accessToken async {
    if (map == null) return "";
    if (needsTokenRefresh() && signedIn) {
      await performTokenRefresh();
    }
    return map['access_token'] ?? "";
  }

  String get refreshToken {
    if (map == null) return "";
    return map['refresh_token'] ?? "";
  }

  String get lastTokenRefresh {
    return map['last_update'];
  }

  bool get loading => _isLoading;

  AuthProvider() {
    validateAuth();
  }

  bool needsTokenRefresh() {
    String lastRefresh = this.lastTokenRefresh ?? "";
    if (lastRefresh.isEmpty) {
      print("should not have happened : last refresh is empty!");
      return true;
    }
    Duration time = (DateTime.now()).difference(DateTime.parse(lastRefresh));
    return time.inMinutes > 50;
  }

  Future<bool> performTokenRefresh() async {
    this._refreshToken = this.refreshToken;
    if (this.refreshToken.isEmpty) {
      //not logged in : log out
      // todo : think of smth here
      print("tried to refresh token when refresh token is empty");
      await this.signout();
      return false;
    }
    String url = authUrlBuilder("access_token");
    dynamic body = "grant_type=refresh_token&refresh_token=$_refreshToken";
    final response =
        await buildRequestAndPost(url, body: body, useAuthHeaders: true);
    if (response.statusCode != 200) {
      // Show error : failed to load token
      // todo: handle error here
      print("failed when refreshing token");
      return false;
    }
    Map<String, dynamic> map = json.decode(response.body);
    String _accessToken = map['access_token'];
    print(_accessToken);
    await this.updateAccessToken(_accessToken);
    return true;
  }

  updateAccessToken(String accessToken) async {
    String lastUpdate = getNowDateAsString();
    map['access_token'] = accessToken;
    map['last_update'] = lastUpdate;

    await this.storage.write(key: 'access_token', value: accessToken);
    await this.storage.write(key: 'last_update', value: lastUpdate);
  }

  updateStorageOnLogin(String accessToken, String refreshToken) async {
    String lastUpdate = getNowDateAsString();
    map['access_token'] = accessToken;
    map['refresh_token'] = refreshToken;
    map['last_update'] = lastUpdate;
    map['signed_in'] = _signedIn.toString();

    await this.storage.write(key: 'refresh_token', value: refreshToken);
    await this.storage.write(key: 'signed_in', value: _signedIn.toString());
    await this.storage.write(key: 'access_token', value: accessToken);
    await this.storage.write(key: 'last_update', value: lastUpdate);
  }

  Future<bool> validateAuth() async {
    startLoading();
    this.map = await storage.readAll();
    this._signedIn = this.signedIn;

    if (this._signedIn) {
      performTokenRefresh();
    }
    stopLoading();
    return true;
  }

  Future<bool> authenticateUser(BuildContext context) async {
    startLoading();

    // generate unique id to make sure the right person logs in.
    String uuid = Uuid().v1();
    print(uuid);

    // listen to localhost requests
    final LocalServer localServer = LocalServer();
    Stream<String> codeStream = await localServer.server();

    // todo : double check code here!
    final String webviewUrl = authUrlBuilder(
        "authorize.compact?client_id=$CLIENT_ID&response_type=code&state=$uuid&redirect_uri=$REDIRECT_URL&duration=permanent&scope=identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread");

    // launch webview
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthWebview(url: webviewUrl),
        ));

    // server returns the first access & state code it receives
    final stream = await codeStream.toList() ?? [];
    String accessCode = stream[0] ?? "";
    String state = stream[1] ?? "";

    // todo: show an error message here
    // error during login (no access/state code provided).
    if (accessCode.isEmpty || state.isEmpty) return false;

    // uuids do not match (potential attack: do not log in)
    if (state != uuid) {
      print("uuid does not match!");
      return false;
    }

    String url = authUrlBuilder("/access_token");
    dynamic body =
        "grant_type=authorization_code&code=$accessCode&redirect_uri=$REDIRECT_URL";
    final response =
        await buildRequestAndPost(url, body: body, useAuthHeaders: true);

    // user has accepted or declined. Close webview
    Navigator.pop(context);
    if (response.statusCode != 200) {
      // todo: show error message
      print("error when logging in : status code not 200");
      _signedIn = false;
      stopLoading();
      return false;
    }

    Map<String, dynamic> map = json.decode(response.body);
    this._accessToken = map['access_token'];
    this._refreshToken = map["refresh_token"];
    if ((_accessToken ?? "").isEmpty || (_refreshToken ?? "").isEmpty) {
      // todo: show error message
      _signedIn = false;
      stopLoading();
      return false;
    }
    _signedIn = true;
    await updateStorageOnLogin(this._accessToken, this._refreshToken);
    stopLoading();
    return _signedIn;
  }

  signout() async {
    startLoading();
    this._signedIn = false;
    await this.storage.deleteAll();
    this.map.clear();
    stopLoading();
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
