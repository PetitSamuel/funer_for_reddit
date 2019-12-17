import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/actions/auth_actions.dart';
import 'package:funer_for_reddit/models/models_export.dart';
import 'package:funer_for_reddit/pages/post_page.dart';
import 'package:funer_for_reddit/providers/actions_provider.dart';
import 'package:funer_for_reddit/providers/comment_provider.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/shared/constants.dart';
import 'package:provider/provider.dart';

/*
  File manages required actions for a post.
  If a user action requires the app to send a comment or upvote,
  it can simply call the helper method here, the method will then delegate 
  all the required actions to the providers.
*/

/*
  Push single post page to navigation stack.
  Handles comment fetching.
*/
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

/*
  Loads comments for a post.
*/
loadComments(BuildContext context, PostModel post) async {
  String token = await getAccessToken(context);
  Provider.of<CommentProvider>(context)
      .fetchComments(post.subredditNamePrefixed, post.id, access: token);
}

/*
  Handle upvoting & downvoting for a post. 
  Sends request & updates values from the feedprovider.
*/
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

/*
  Transforms a bool to int.
  True : 1
  False : -1
  Null: 0
*/
int boolToInt(bool val) {
  if (val == true) return 1;
  if (val == false) return -1;
  return 0;
}

/*
  Transforms an int to a boolean (opposite as above method).
*/
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
