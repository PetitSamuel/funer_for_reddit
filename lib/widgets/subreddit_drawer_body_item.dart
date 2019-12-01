import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/subreddit_models/subscribed_subreddit_model.dart';

/*
 * Widget for a single widget element in the body of the drawer.
 * Displays a single subreddit a user is subrscribed to as a list tile.
 * Shows the name and icon of the subreddit.
 * Also loads the subreddit on click.
*/
Widget subredditDrawerBodyItem(BuildContext context, SubredditModel current) {
  String iconUrl = current.iconImg ?? "";
  if (iconUrl.isEmpty) iconUrl = current.communityIcon;
  // todo : handle empty icon
  return ListTile(
    title: Text(current.displayName),
    leading: iconUrl.isEmpty
        ? Icon(Icons.error_outline)
        : CachedNetworkImage(
            imageUrl: iconUrl,
            imageBuilder: (context, imageProvider) => Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
    onTap: () {
      // todo : handle tap
      print(current.url);
      /*
      Provider.of<FeedProvider>(context)
          .setSubredditAndFetchWithClear(current.url);
      Navigator.pop(context);
      */
    },
  );
}
