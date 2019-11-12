import 'package:flutter/material.dart';
import 'package:funer_for_reddit/helpers/html_convert.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/helpers/navigator_helper_functions.dart';
import 'package:funer_for_reddit/models/post_models/post_preview_model.dart';
import 'package:funer_for_reddit/widgets/feed/feed_body_item_actions_widget.dart';
import 'package:funer_for_reddit/widgets/feed/feed_body_item_information_widget.dart';
import 'package:funer_for_reddit/widgets/media/video_player_widget.dart';

Widget feedBodyItem(BuildContext context, PostModel post) {
  PostPreviewImageSource imgsrc = PostModel.getPreviewImageSource(post);
  bool hasVideo = PostModel.hasVideo(post);
  var video = PostModel.getPostVideo(post);
  return Card(
      child: ListTile(
    onTap: () {
      pushPostPage(context, post);
    },
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          child: FlatButton(
            child: Text(post.subredditNamePrefixed),
            onPressed: () => print("cool"),
            /*
onPressed: () {
              if (Provider.of<PageInformationProvider>(context).isOnPostPage)
                Navigator.pop(context);
              Provider.of<FeedProvider>(context).setSubredditAndFetchWithClear(
                  post.subredditNamePrefixed + "/");
            },
            */
          ),
        ),
        Text("·"),
        Flexible(
          child: FlatButton(
            child: Text("u/" + post.author),
            onPressed: () => print("cool"),
            /*
onPressed: () {
              if (Provider.of<PageInformationProvider>(context).isOnPostPage)
                Navigator.pop(context);
              Provider.of<FeedProvider>(context).setSubredditAndFetchWithClear(
                  post.subredditNamePrefixed + "/");
            },
            */
          ),
        ),
      ],
    ),
    subtitle: Column(
      children: <Widget>[
        Text(
          post.title + "\n",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        if (post.selftext.length != 0)
          Text(
            post.selftext,
            overflow: TextOverflow.fade,
            maxLines: 3,
          ),
        feedBodyItemInformation(context, post),
        // todo : parse media part of answer & use it for gifs displaying
        if (imgsrc != null && !hasVideo)
          Image.network(
            htmlUnescapeConvert(imgsrc.url),
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
