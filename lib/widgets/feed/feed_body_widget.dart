import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';

import 'feed_body_item.dart';

/*
 * The widget that displays the feed (list of posts).
 * Loads more posts when user comes to the end of the list.
*/
Widget feedBody(List<PostModel> posts, ScrollController _scrollCtrl) {
  // if there are no posts, display nothing
  if (posts == null || posts.length == 0) {
    return SafeArea(
      child: Container(),
    );
  }
  return Container(
      child: Expanded(
          child: ListView.builder(
    padding: EdgeInsets.only(bottom: 4),
    controller: _scrollCtrl,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: posts.length,
    itemBuilder: (context, int index) {
      return feedBodyItem(context, posts[index]);
    },
  )));
}
