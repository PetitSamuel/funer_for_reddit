import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/pages/post_page.dart';
import 'package:funer_for_reddit/pages/subreddit_page.dart';
import 'package:funer_for_reddit/providers/auth_provider.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:provider/provider.dart';

bool loggedIn(BuildContext context) {
  return Provider.of<AuthProvider>(context).signedIn;
}

onStartup(BuildContext context) async {
  // methods executed to automatically load user info on app load.
  String token = await getAccessToken(context);
  Provider.of<FeedProvider>(context).fetchPostsListing("", accessToken: token);
  if (token == null || token.isEmpty) {
    print("access token is empty, abort loading user profile/subs");
    return;
  }
  Provider.of<UserProvider>(context).handleGetMe(token);
  Provider.of<UserProvider>(context).handleGetUserSubreddits(token);
}

login(BuildContext context) async {
  bool status =
      await Provider.of<AuthProvider>(context).authenticateUser(context);
  // todo : if success then load user info
  if (!status) return;
  String token = await getAccessToken(context);
  Provider.of<UserProvider>(context).handleGetMe(token);
  Provider.of<UserProvider>(context).getUserSubreddits(token);
  Provider.of<FeedProvider>(context).fetchPostsListing("", accessToken: token);
}

signout(BuildContext context) {
  Provider.of<AuthProvider>(context).signout();
  Provider.of<UserProvider>(context).clearStorage();
}

loadUserProfile(BuildContext context) async {
  String token = await getAccessToken(context);
  if (token == null || token.isEmpty) {
    print("access token is empty, abort loading user profile");
    return;
  }
  Provider.of<UserProvider>(context).handleGetMe(token);
}

loadUserSubs(BuildContext context) async {
  String token = await getAccessToken(context);
  if (token == null || token.isEmpty) {
    print("access token is empty, abort loading user subs");
    return;
  }
  Provider.of<UserProvider>(context).handleGetUserSubreddits(token);
}

loadPosts(BuildContext context) async {
  String token = await getAccessToken(context);
  Provider.of<FeedProvider>(context).fetchPostsListing("", accessToken: token);
}

Future<String> getAccessToken(BuildContext context) async {
  return await Provider.of<AuthProvider>(context).accessToken;
}

bool isAuthLoading(BuildContext context) {
  return Provider.of<AuthProvider>(context).loading;
}

pushSubredditPage(BuildContext context, String subreddit) async {
  String currentSub = Provider.of<FeedProvider>(context).subreddit;
  if (currentSub == subreddit.toLowerCase()) {
    print("not pushing !");
    return;
  }
  String token = await getAccessToken(context);
  Provider.of<FeedProvider>(context)
      .fetchPostsListing(subreddit, accessToken: token);
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubredditPage(subreddit: subreddit),
      )).then((value) async {
    String token = await getAccessToken(context);
    Provider.of<FeedProvider>(context)
        .fetchPostsListing("", accessToken: token);
  });
}

pushPostPage(BuildContext context, PostModel post) async {
  // todo : fetch comments
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostPage(post: post),
      ));
}
