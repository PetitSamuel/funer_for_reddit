import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/models/Subreddit.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:provider/provider.dart';

/*
  List of subreddits displayed as a Listview (used in the drawer)
*/
Widget drawerSubredditsListView() {
  return Consumer<UserProvider>(
    builder: (BuildContext context, UserProvider model, _) {
      if (model.isLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (model.signedIn && model.subscribedSubReddits.length != 0) {
        return Container(
          child: ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, int index) {
              Subreddit current = model.subscribedSubReddits[index];
              String iconUrl = model.subscribedSubReddits[index].communityIcon;
              return ListTile(
                title: Text(current.displayName),
                leading: iconUrl.isEmpty
                    ? Icon(Icons.error_outline)
                    : CircleAvatar(
                        child: CachedNetworkImage(
                          imageUrl: current.communityIcon,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                onTap: () {
                  print(current.url);
                },
              );
            },
            itemCount: model.subscribedSubReddits.length,
          ),
        );
      } else {
        return SafeArea(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        );
      }
    },
  );
}
