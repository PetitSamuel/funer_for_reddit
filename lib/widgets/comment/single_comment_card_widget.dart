import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/models_export.dart';

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  iconSize: 20,
                  icon: Icon(
                    Icons.thumb_up,
                  ),
                  onPressed: () {
                    print("up");
                  },
                ),
                IconButton(
                  iconSize: 20,
                  icon: Icon(
                    Icons.thumb_down,
                  ),
                  onPressed: () {
                    print("down");
                  },
                ),
                IconButton(
                  iconSize: 20,
                  icon: Icon(
                    Icons.reply,
                  ),
                  onPressed: () {
                    print("reply");
                  },
                ),
              ],
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
