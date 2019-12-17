import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/actions/auth_actions.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:provider/provider.dart';

/*
  File manages required actions for the user.
  If a user action requires the app to load user information,
  it can simply call the helper method here, the method will then delegate 
  all the required actions to the providers.
*/

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
