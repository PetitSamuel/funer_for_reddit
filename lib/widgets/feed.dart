import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_model.dart';

Widget subredditFeedListView(List<SinglePostModel> posts) {
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
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: posts.length,
    itemBuilder: (context, int index) {
      var post = posts[index];
      bool isDisplayingSubstring = post.selftext.length > 200;
      int length = isDisplayingSubstring ? 200 : post.selftext.length;
      return Card(
          child: ListTile(
        title: Text(posts[index].author + " - " + posts[index].title),
        subtitle: post.selftext.length == 0
            ? null
            : Text((post.selftext.substring(0, length) ?? "") +
                (isDisplayingSubstring ? "..." : "")),
      ));
    },
  )));
}
