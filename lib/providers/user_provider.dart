import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funer_for_reddit/authentification/auth_webview.dart';
import 'package:funer_for_reddit/shared/requests.dart';

class UserProvider with ChangeNotifier {
  final String cool = "";
  UserProvider() {
    print("yo");
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
