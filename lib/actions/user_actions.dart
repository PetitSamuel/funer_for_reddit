import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/actions/auth_actions.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:provider/provider.dart';

/*
  Load user subscribed subreddits.
*/
loadUserSubs(BuildContext context) async {
  String token = await getAccessToken(context);
  if (token == null || token.isEmpty) {
    print("access token is empty, abort loading user subs");
    return;
  }
  Provider.of<UserProvider>(context).handleGetUserSubreddits(token);
}

loadUserProfile(BuildContext context) async {
  String token = await getAccessToken(context);
  if (token == null || token.isEmpty) {
    print("access token is empty, abort loading user profile");
    return;
  }
  Provider.of<UserProvider>(context).handleGetMe(token);
}
