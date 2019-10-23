import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funer_for_reddit/authentification/auth_webview.dart';
import 'package:funer_for_reddit/secret/secret.dart';
import 'package:funer_for_reddit/authentification/local_server.dart';
import 'package:funer_for_reddit/shared/requests.dart';

class AuthentificatorProvider with ChangeNotifier {
  bool _signedIn = false;
  bool _isLoading = false;
  String _authToken;
  String _refreshToken;

  AuthentificatorProvider() {
    validateAuth();
  }

  bool get signedIn => _signedIn;
  String get authToken => _authToken;
  String get refreshToken => _refreshToken;
  bool get isLoading => _isLoading;

  final storage = new FlutterSecureStorage();

  Future<bool> validateAuth() async {
    loading();
    _signedIn = (await storage.read(key: 'signedIn') ?? "") == "true";
    // if signed in load tokens as well
    if (_signedIn) {
      _refreshToken = await storage.read(key: "refreshToken") ?? "";
      _authToken = await storage.read(key: "authToken") ?? "";
    }
    stopLoading();
    return signedIn;
  }

  Future<bool> authenticateUser(BuildContext context) async {
    loading();
    // start a new instance of the server that listens to localhost requests
    final LocalServer localServer = LocalServer();
    Stream<String> codeStream = await localServer.server();

    final String webviewUrl = urlBuilder(
        "/authorize.compact?client_id=$CLIENT_ID&response_type=code&state=randichid&redirect_uri=$REDIRECT_URL&duration=permanent&scope=identity");

    // launch webview!
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

    String url = urlBuilder("/access_token", auth: true);
    dynamic body =
        "grant_type=authorization_code&code=$accessCode&redirect_uri=$REDIRECT_URL";
    final response = await buildRequestAndPost(url, body: body);

    // user has accepted or declined. Close webview
    Navigator.pop(context);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      _authToken = map['access_token'];
      _refreshToken = map["refresh_token"];
      if ((_authToken ?? "").isEmpty || (_refreshToken ?? "").isEmpty) {
        print("not logged in!");
        _signedIn = false;
        stopLoading();
        return false;
      }
      _signedIn = true;
      await storeUserCredentials();
    } else {
      // todo: show error message
      _signedIn = false;
    }

    print("Signed in status: " + _signedIn.toString());
    stopLoading();
    return _signedIn;
  }

  Future<void> storeUserCredentials() async {
    await storage.write(key: "authToken", value: _authToken);
    await storage.write(key: "refreshToken", value: _refreshToken);
    await storage.write(key: "signedIn", value: _signedIn.toString());
    await storage.write(
      key: "lastTokenRefresh",
      value: DateTime.now().toIso8601String(),
    );
  }

  Future<void> performTokenRefresh() async {
    loading();

    String url = urlBuilder("access_token", auth: true);
    dynamic body = "grant_type=refresh_token&refresh_token=$_refreshToken";
    final response = await buildRequestAndPost(url, body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      _authToken = map['access_token'];
      print(_authToken);
      await storeUserCredentials();
    } else {
      // Show error : failed to load token
      // todo: handle error here
      print("failed when refreshing token");
    }

    await loadUserInformation();
    stopLoading();
  }

  Future<bool> needsTokenRefresh() async {
    String lastRefresh = await storage.read(key: 'lastTokenRefresh');
    if (lastRefresh.isEmpty) {
      return true;
    }
    Duration time = (DateTime.now()).difference(DateTime.parse(lastRefresh));
    print(time.toString());
    return time.inMinutes > 50;
  }

  Future<void> signOutUser() async {
    loading();
    // delete: authToken, refreshToken, signedIn, lastTokenRefresh
    await storage.deleteAll();
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

  Future<void> loadUserInformation() async {
    String url = urlBuilder("me");
    final response = await buildRequestAndGet(url);

    print("yoyoyoyo");
    /*
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> subsList;
    final subredditResponse = await http.get(
      "https://oauth.reddit.com/subreddits/mine/subscriber",
      headers: {
        'Authorization': 'bearer ' + _authToken,
        'User-Agent': 'fritter_for_reddit by /u/SexusMexus'
      },
    );
    Map<String, dynamic> subRedditMap = json.decode(subredditResponse.body);
    List<dynamic> myList = subRedditMap['data']['children'];
//    print(myList);
    subsList = myList.map((e) {
      String icon_url = "";
      if (e['data']['icon_img'] == "") {
        if (e['data']['community_icon'] == "") {
          icon_url =
              e['data']['header_img'] != null ? e['data']['header_img'] : "";
        } else {
          icon_url = e['data']['community_icon'];
        }
      } else {
        icon_url = e['data']['icon_img'];
      }
      return (new Subreddit(
          display_name: e['data']['display_name'],
          header_img: e['data']['header_img'],
          display_name_prefixed: e['data']['display_name_prefixed'],
          subscribers: e['data']['subscribers'].toString(),
          community_icon: icon_url,
          user_is_subscriber: e['data']['user_is_subscriber'].toString(),
          url: e['data']['url']));
    }).toList();
    for (Subreddit x in subsList) print(x.community_icon);
    userInformation = new AppUserInformation(
      icon_color: map['subreddit']['icon_color'],
      icon_img: map['subreddit']['icon_img'],
      display_name_prefixed: map['subreddit']['display_name_prefixed'],
      comment_karma: map['comment_karma'].toString(),
      link_karma: map['link_karma'].toString(),
      subredditsList: subsList,
    );
  }
  */
  }
}
