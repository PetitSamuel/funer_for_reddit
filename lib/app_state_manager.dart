import 'package:flutter/cupertino.dart';
import 'package:funer_for_reddit/providers/auth_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:provider/provider.dart';

bool loggedIn(BuildContext context) {
  return Provider.of<AuthProvider>(context).signedIn;
}

login(BuildContext context) async {
  bool status =
      await Provider.of<AuthProvider>(context).authenticateUser(context);
  // todo : if success then load user info
  if (!status) return;
  String token = Provider.of<AuthProvider>(context).accessToken;
  Provider.of<UserProvider>(context).handleGetMe(token);
  Provider.of<UserProvider>(context).getUserSubreddits(token);
}

signout(BuildContext context) {
  Provider.of<AuthProvider>(context).signout();
  Provider.of<UserProvider>(context).clearStorage();
}

loadUserProfile(BuildContext context) {
  String token = getAccessToken(context);
  if (token == null || token.isEmpty) {
    print("access token is empty, abort loading user profile");
    return;
  }
  print("loading user profiles");
  Provider.of<UserProvider>(context).handleGetMe(token);
}

String getAccessToken(BuildContext context) {
  return Provider.of<AuthProvider>(context).accessToken;
}

bool isAuthLoading(BuildContext context) {
  return Provider.of<AuthProvider>(context).loading;
}
