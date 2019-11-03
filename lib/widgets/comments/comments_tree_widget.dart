import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/comments/comment_model.dart';
import 'package:funer_for_reddit/widgets/comments/single_comment_card_widget.dart';

/*
 * Takes a context and list of comments. 
 * Returns a Widget which represent all of those comments as a tree.
*/
Widget commentsTree(BuildContext context, List<CommentModel> comments) {
  if (comments == null || comments.length <= 0) {
    return Container();
  }
  return Container(
    child: ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        CommentModel item = comments[index];
        return singleCommentCardWidget(item);
      },
      itemCount: comments.length,
    ),
  );
}
