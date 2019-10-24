import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:funer_for_reddit/authentification/auth_webview.dart';
import 'package:funer_for_reddit/helpers/secure_storage_helper.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:funer_for_reddit/secret/secret.dart';
import 'package:funer_for_reddit/authentification/local_server.dart';
import 'package:funer_for_reddit/shared/requests.dart';
import 'package:provider/provider.dart';

class AuthentificatorProvider with ChangeNotifier {
  bool _signedIn = false;
  bool _isLoading = false;
  String _accessToken;
  String _refreshToken;

  AuthentificatorProvider() {
    validateAuth();
  }

  final SecureStorageHelper storage = new SecureStorageHelper();

  bool get signedIn => storage.signInStatus;
  bool get isLoading => _isLoading;

  Future<bool> validateAuth() async {
    loading();
    await storage.init();

    if (storage.signInStatus) {
      performTokenRefresh();
    }

    stopLoading();
    return signedIn;
  }

  Future<bool> authenticateUser(BuildContext context) async {
    loading();
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
      _signedIn = false;
      stopLoading();
      return false;
    }

    Map<String, dynamic> map = json.decode(response.body);
    _accessToken = map['access_token'];
    _refreshToken = map["refresh_token"];

    if ((_accessToken ?? "").isEmpty || (_refreshToken ?? "").isEmpty) {
      // todo: show error message
      _signedIn = false;
      stopLoading();
      return false;
    }

    _signedIn = true;
    await storage.updateCredentials(_accessToken, _refreshToken, _signedIn);
    stopLoading();
    Provider.of<UserProvider>(context).loadUserInformation();
    return _signedIn;
  }

  Future<void> performTokenRefresh() async {
    loading();
    await storage.performTokenRefresh();
    stopLoading();
  }

  Future<void> signOutUser() async {
    loading();
    // delete: authToken, refreshToken, signedIn, lastTokenRefresh
    await storage.clearStorage();
    _signedIn = false;
    stopLoading();
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
