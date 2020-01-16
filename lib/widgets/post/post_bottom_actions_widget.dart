import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/app_actions_manager.dart';
import 'package:funer_for_reddit/models/models_export.dart';
import 'package:funer_for_reddit/shared/constants.dart';
import 'package:share/share.dart';

Widget postBottomActions(BuildContext context, PostModel post) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      IconButton(
        color: post.likes == true ? Colors.orangeAccent : Colors.white,
        icon: Icon(Icons.arrow_upward),
        onPressed: () {
          print("up");
          votePost(context, post, UPVOTE_DIR);
        },
      ),
      IconButton(
        icon: Icon(Icons.arrow_downward),
        color: post.likes == false ? Colors.blue : Colors.white,
        onPressed: () {
          print("down");
          votePost(context, post, DOWNVOTE_DIR);
        },
      ),
      IconButton(
        icon: Icon(Icons.star),
        onPressed: () => print("starred"),
      ),
      IconButton(
        icon: Icon(Icons.share),
        onPressed: () async =>
            await Share.share('www.reddit.com${post.permalink}'),
      ),
    ],
  );
}
