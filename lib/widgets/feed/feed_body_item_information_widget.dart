import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/helpers/number_formatting_helper_functions.dart';

Widget feedBodyItemInformation(BuildContext context, PostModel post) {
  return Container(
    margin: EdgeInsets.only(top: 4, bottom: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          fromIntToFormattedKString(post.ups),
          style: TextStyle(
            color: post.likes == true
                ? Colors.orange
                : post.likes == false ? Colors.blue : Colors.white,
          ),
        ),
        Text(fromIntToFormattedKString(post.numComments) + " comments"),
        Text(
          post.subredditNamePrefixed,
        ),
      ],
    ),
  );
}
