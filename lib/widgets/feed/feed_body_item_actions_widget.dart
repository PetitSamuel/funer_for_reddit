import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/helpers/navigator_helper_functions.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

Widget feedBodyItemActions(BuildContext context, PostModel post) {
  var voteStatus = post.likes;
  Color upArrowColor = voteStatus == true ? Colors.deepOrange : Colors.grey;
  Color downArrowColor = voteStatus == false ? Colors.blueAccent : Colors.grey;
  return Container(
    margin: EdgeInsets.only(top: 4, bottom: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_upward,
            color: upArrowColor,
          ),
          onPressed: () {
            Provider.of<FeedProvider>(context)
                .votePost(post.name, "up", post.likes);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_downward,
            color: downArrowColor,
          ),
          onPressed: () {
            Provider.of<FeedProvider>(context)
                .votePost(post.name, "down", post.likes);
          },
        ),
        IconButton(
          icon: Icon(Icons.comment),
          onPressed: () {
            pushPostPage(context, post);
          },
        ),
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () async =>
              await Share.share('www.reddit.com${post.permalink}'),
        ),
      ],
    ),
  );
}
