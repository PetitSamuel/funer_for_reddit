import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:funer_for_reddit/widgets/drawer/subreddit_drawer_body_item.dart';
import 'package:provider/provider.dart';

/*
  List of subreddits displayed as a Listview (used in the drawer)
*/
Widget subredditDrawerBody() {
  return Consumer<UserProvider>(
    builder: (BuildContext context, UserProvider model, _) {
      if (!model.signedIn || model.subscribedSubReddits.length == 0) {
        return SafeArea(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        );
      }
      return Column(children: <Widget>[
        Container(
          child: ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, int index) {
              return subredditDrawerBodyItem(
                  context, model.subscribedSubReddits[index]);
            },
            itemCount: model.subscribedSubReddits.length,
          ),
        ),
        if (model.isLoadingSubreddits)
          Center(
            child: CircularProgressIndicator(),
          ),
      ]);
    },
  );
}
