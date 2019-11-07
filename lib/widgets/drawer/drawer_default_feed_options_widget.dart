import 'package:flutter/material.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:provider/provider.dart';

Widget drawerDefaultFeedOptions(BuildContext context, Function goHomePage) {
  return Container(
    child: ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        ListTile(
          title: Text("Home page"),
          leading: Icon(
            Icons.home,
            color: Provider.of<FeedProvider>(context).subreddit == ""
                ? Colors.blue
                : Colors.white,
          ),
          onTap: () {
            goHomePage();
          },
        ),
        Divider(),
      ],
    ),
  );
}
