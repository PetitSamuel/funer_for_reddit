import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/comments/comment_model.dart';
import 'package:funer_for_reddit/widgets/single_comment_card_widget.dart';

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
