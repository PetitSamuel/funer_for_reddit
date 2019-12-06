import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/comments/comment_model.dart';

/*
 * Widget for a single comment. Recursively generates reply comments.
*/
Widget singleCommentCardWidget(CommentModel comment, {double margin = 0}) {
  return Container(
    margin: EdgeInsets.only(left: margin),
    child: Column(
      children: <Widget>[
        ExpansionTile(
          title: Text(comment.author),
          initiallyExpanded: true,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: margin + 4, bottom: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  comment.body,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            for (int i = 0;
                comment.replies != null && i < comment.replies.length;
                i++)
              singleCommentCardWidget(comment.replies[i], margin: margin + 4),
          ],
        ),
      ],
    ),
  );
}
