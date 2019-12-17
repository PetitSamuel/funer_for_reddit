import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/models/models_export.dart';
import 'package:funer_for_reddit/shared/date_time_helper_functions.dart';
import 'package:funer_for_reddit/shared/number_formatting_helper_functions.dart';

Widget feedBodyItemInformation(PostModel post) {
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
        Text(getTimeAgoAsString(post.created)),
      ],
    ),
  );
}
