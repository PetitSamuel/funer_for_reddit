import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/providers/auth_provider.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:provider/provider.dart';

bool isSignedIn(BuildContext context) {
  return Provider.of<AuthProvider>(context).signedIn;
}

login(BuildContext context) async {
  bool status =
      await Provider.of<AuthProvider>(context).authenticateUser(context);
  // todo : if success then load user info
  if (!status) return;
  String token = await getAccessToken(context);
  Provider.of<UserProvider>(context).handleGetMe(token);
  Provider.of<UserProvider>(context).getUserSubreddits(token);
  Provider.of<FeedProvider>(context).fetchPosts("", accessToken: token);
}

signout(BuildContext context) {
  Provider.of<AuthProvider>(context).signout();
  Provider.of<UserProvider>(context).clearStorage();
}

Future<String> getAccessToken(BuildContext context) async {
  return await Provider.of<AuthProvider>(context).accessToken;
}

bool isAuthLoading(BuildContext context) {
  return Provider.of<AuthProvider>(context).loading;
}
