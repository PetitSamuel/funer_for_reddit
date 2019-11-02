import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/pages/post_page.dart';
import 'package:funer_for_reddit/providers/comments_provider.dart';
import 'package:funer_for_reddit/shared/date_time_helper_functions.dart';
import 'package:funer_for_reddit/shared/number_formatting_helper_functions.dart';
import 'package:funer_for_reddit/widgets/video_player_widget.dart';
import 'package:provider/provider.dart';

Widget subredditFeedListView(
    List<SinglePostModel> posts, ScrollController _scrollCtrl) {
  if (posts == null || posts.length == 0) {
    return SafeArea(
      child: Container(
        color: ThemeData.light().backgroundColor,
      ),
    );
  }
  return Container(
      child: Expanded(
          child: ListView.builder(
    padding: EdgeInsets.only(bottom: 48),
    controller: _scrollCtrl,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: posts.length,
    itemBuilder: (context, int index) {
      var post = posts[index];
      return Card(
          child: ListTile(
        onTap: () {
          pushPostPage(context, post);
        },
        title: Text(posts[index].author +
            " - " +
            posts[index].title +
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
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    fromIntToFormattedKString(post.ups),
                  ),
                  Text(fromIntToFormattedKString(post.numComments) +
                      " comments"),
                  Text(
                    post.subredditNamePrefixed,
                  ),
                ],
              ),
            ),
            if (post.media != null && post.media['reddit_video'] != null)
              VideoPlayerScreen(
                  url: post.media['reddit_video']['fallback_url']),
            if (post.crossParent != null &&
                post.crossParent.media != null &&
                post.crossParent.media['reddit_video'] != null)
              VideoPlayerScreen(
                  url: post.crossParent.media['reddit_video']['fallback_url']),
            /*
                    else if(isURL(post.thumbnail ?? ""))   
                      Center(
                        child: Image.network(
                          post.url,
                          fit: BoxFit.fitWidth,
                        ),
                      )
                      */
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_upward),
                    onPressed: () => print("pressed :)"),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_downward),
                    onPressed: () => print("pressed :)"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    },
  )));
}

pushPostPage(BuildContext context, SinglePostModel post) {
  Provider.of<CommentsProvider>(context)
      .fetchComments(post.subredditNamePrefixed, post.id);
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostPage(post: post),
      )).then((value) {
    Provider.of<CommentsProvider>(context).clearComments();
  });
}
