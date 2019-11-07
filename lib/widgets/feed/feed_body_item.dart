import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/helpers/date_time_helper_functions.dart';
import 'package:funer_for_reddit/helpers/navigator_helper_functions.dart';
import 'package:funer_for_reddit/models/post_models/post_preview_model.dart';
import 'package:funer_for_reddit/widgets/feed/feed_body_item_actions_widget.dart';
import 'package:funer_for_reddit/widgets/feed/feed_body_item_information_widget.dart';
import 'package:funer_for_reddit/widgets/media/video_player_widget.dart';
import 'package:html_unescape/html_unescape.dart';

Widget feedBodyItem(BuildContext context, PostModel post) {
  PostPreviewImageSource imgsrc = PostModel.getPreviewImageSource(post);
  final HtmlUnescape _htmlUnescape = new HtmlUnescape();
  bool hasVideo = PostModel.hasVideo(post);
  var video = PostModel.getPostVideo(post);
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
        if (imgsrc != null && !hasVideo)
          Image.network(
            _htmlUnescape.convert(imgsrc.url),
          ),
        if (hasVideo)
          VideoPlayerScreen(
            url: video['fallback_url'],
            h: video['height'],
            w: video['width'],
          ),
        feedBodyItemActions(context, post),
      ],
    ),
  ));
}
