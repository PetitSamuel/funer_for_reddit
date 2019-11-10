import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/subreddit_models/subscribed_subreddit_model.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:provider/provider.dart';

/*
 * Widget for a single widget element in the body of the drawer.
 * Displays a single subreddit a user is subrscribed to as a list tile.
 * Shows the name and icon of the subreddit.
 * Also loads the subreddit on click.
*/
Widget subredditDrawerBodyItem(BuildContext context, SubredditModel current) {
  String iconUrl = current.communityIcon;
  return ListTile(
    title: Text(current.displayName),
    leading: iconUrl.isEmpty
        ? Icon(Icons.error_outline)
        : CircleAvatar(
            child: CachedNetworkImage(
              imageUrl: current.communityIcon,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
    onTap: () {
      Provider.of<FeedProvider>(context)
          .setSubredditAndFetchWithClear(current.url);
      Navigator.pop(context);
    },
  );
}
