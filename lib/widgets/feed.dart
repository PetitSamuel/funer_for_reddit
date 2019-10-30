import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/shared/date_time_helper_functions.dart';
import 'package:funer_for_reddit/shared/number_formatting_helper_functions.dart';

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
        title: Text(posts[index].author + " - " + posts[index].title),
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
                  Text(post.subreddit),
                  //HERE
                  Text(getTimeAgoAsString(post.created)),
                ],
              ),
            ),
          ],
        ),
      ));
    },
  )));
}
