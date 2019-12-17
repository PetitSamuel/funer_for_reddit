import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/actions/auth_actions.dart';
import 'package:funer_for_reddit/providers/auth_provider.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:provider/provider.dart';

/*
  Actions to execute when the app first launches.
*/
onStartup(BuildContext context) async {
  bool signedIn = await Provider.of<AuthProvider>(context).signedInAsync;
  String token = "";
  if (signedIn) {
    token = await getAccessToken(context);
  }

  Provider.of<FeedProvider>(context).fetchPosts("", accessToken: token);
  if (token == null || token.isEmpty) {
    print("access token is empty, abort loading user profile/subs");
    return;
  }
  Provider.of<UserProvider>(context).handleGetMe(token);
  Provider.of<UserProvider>(context).handleGetUserSubreddits(token);
}
