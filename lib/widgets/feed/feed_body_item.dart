import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/helpers/date_time_helper_functions.dart';
import 'package:funer_for_reddit/helpers/navigator_helper_functions.dart';
import 'package:funer_for_reddit/widgets/feed/feed_body_item_actions_widget.dart';
import 'package:funer_for_reddit/widgets/feed/feed_body_item_information_widget.dart';
import 'package:funer_for_reddit/widgets/media/video_player_widget.dart';

Widget feedBodyItem(BuildContext context, PostModel post) {
  return Card(
      child: ListTile(
    onTap: () {
      pushPostPage(context, post);
    },
    title: Text(post.author +
        " - " +
        post.title +
        ' - (' +
        getTimeAgoAsString(post.created) +
        ').'),
    subtitle: Column(
      children: <Widget>[
        if (post.selftext.length != 0)
          Text(
            post.selftext,
            overflow: TextOverflow.fade,
            maxLines: 3,
          ),
        feedBodyItemInformation(context, post),
        if (post.media != null && post.media['reddit_video'] != null)
          VideoPlayerScreen(
            url: post.media['reddit_video']['fallback_url'],
            h: post.media['reddit_video']['height'],
            w: post.media['reddit_video']['width'],
          ),
        if (post.crossParent != null &&
            post.crossParent.media != null &&
            post.crossParent.media['reddit_video'] != null)
          VideoPlayerScreen(
            url: post.crossParent.media['reddit_video']['fallback_url'],
            h: post.crossParent.media['reddit_video']['height'],
            w: post.crossParent.media['reddit_video']['width'],
          ),
        feedBodyItemActions(context, post),
      ],
    ),
  ));
}
