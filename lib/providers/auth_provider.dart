import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/authentification/auth_webview.dart';
import 'package:funer_for_reddit/authentification/local_server.dart';
import 'package:funer_for_reddit/secret/secret.dart';
import 'package:funer_for_reddit/shared/requests_shared.dart';

class AuthProvider with ChangeNotifier {
  bool _signedIn = false;
  bool _isLoading = false;
  String _accessToken = "";
  String _refreshToken = "";

  bool get signedIn => _signedIn;
  bool get loading => _isLoading;
  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  AuthProvider() {
    validateAuth();
  }

  Future<bool> validateAuth() async {
    startLoading();
    // todo : handle this when storing tokens.
    stopLoading();
    return true;
  }

  Future<bool> authenticateUser(BuildContext context) async {
    startLoading();
    // listen to localhost requests
    final LocalServer localServer = LocalServer();
    Stream<String> codeStream = await localServer.server();

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
      print("error m8");
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
    // todo : store tokens somehow
    stopLoading();
    return _signedIn;
  }

  signout() {
    startLoading();
    this._signedIn = false;
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
