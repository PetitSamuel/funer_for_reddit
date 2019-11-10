import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/helpers/number_formatting_helper_functions.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/providers/page_information_provider.dart';
import 'package:provider/provider.dart';

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
        Flexible(
          child: FlatButton(
            child: Text(post.subredditNamePrefixed),
            onPressed: () {
              if (Provider.of<PageInformationProvider>(context).isOnPostPage)
                Navigator.pop(context);
              Provider.of<FeedProvider>(context).setSubredditAndFetchWithClear(
                  post.subredditNamePrefixed + "/");
            },
            textColor: Colors.lightBlueAccent,
          ),
        ),
      ],
    ),
  );
}
