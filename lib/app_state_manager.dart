import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/pages/post_page.dart';
import 'package:funer_for_reddit/pages/subreddit_page.dart';
import 'package:funer_for_reddit/providers/actions_provider.dart';
import 'package:funer_for_reddit/providers/auth_provider.dart';
import 'package:funer_for_reddit/providers/comment_provider.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:funer_for_reddit/shared/constants.dart';
import 'package:provider/provider.dart';

bool loggedIn(BuildContext context) {
  return Provider.of<AuthProvider>(context).signedIn;
}

onStartup(BuildContext context) async {
  // methods executed to automatically load user info on app load.
  bool signedIn = await Provider.of<AuthProvider>(context).signedInAsync;
  print(signedIn);
  String token = "";
  if (signedIn) {
    token = await getAccessToken(context);
  }

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

updateSubredditNoNewPage(BuildContext context, String subreddit) async {
  String currentSub = Provider.of<FeedProvider>(context).subreddit;
  if (currentSub == subreddit.toLowerCase()) {
    print("not pushing !");
    return;
  }
  String token = await getAccessToken(context);
  Provider.of<FeedProvider>(context)
      .fetchPostsListing(subreddit, accessToken: token);
}

pushPostPage(BuildContext context, PostModel post) async {
  String token = await getAccessToken(context);
  Provider.of<CommentProvider>(context)
      .fetchComments(post.subredditNamePrefixed, post.id, access: token);
  // todo : fetch comments
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostPage(post: post),
      ));
}

loadComments(BuildContext context, PostModel post) async {
  String token = await getAccessToken(context);
  Provider.of<CommentProvider>(context)
      .fetchComments(post.subredditNamePrefixed, post.id, access: token);
}

votePost(BuildContext context, PostModel post, int dir) async {
  String token = await getAccessToken(context);
  if (token.isEmpty) {
    print("error : empty access token");
    return;
  }
  // send vote & return the direction after request is sent.
  int status = dir == UPVOTE_DIR
      ? await Provider.of<ActionsProvider>(context)
          .upvote(post.name, post.likes, token)
      : await Provider.of<ActionsProvider>(context)
          .downvote(post.name, post.likes, token);

  // call failed.
  if (status == null) return;

  // value to add to post.ups
  int diff = status - boolToInt(post.likes);

  // values to overwritte post.likes
  bool newLikes = intToBool(status);
  Provider.of<FeedProvider>(context).updateLikes(post, newLikes, diff);
}

int boolToInt(bool val) {
  if (val == true) return 1;
  if (val == false) return -1;
  return 0;
}

bool intToBool(int v) {
  switch (v) {
    case 1:
      return true;
    case -1:
      return false;
    default:
      return null;
  }
}
