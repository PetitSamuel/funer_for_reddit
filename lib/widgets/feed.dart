import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_model.dart';

Widget subredditFeedListView(
    List<SinglePostModel> posts, ScrollController _scrollCtrl) {
  if (posts == null || posts.length == 0) {
    return SafeArea(
      child: Container(
        color: ThemeData.light().backgroundColor,
      ),
    );
  }
  print(posts.length);
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
                    post.ups.toString(),
                  ),
                  Text(post.numComments.toString() + " comments"),
                  Text(post.subreddit),
                ],
              ),
            ),
          ],
        ),
      ));
    },
  )));
}
