import 'package:flutter/material.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/widgets/popup_buttons/sort_options_popup_menu.dart';
import 'package:funer_for_reddit/widgets/popup_buttons/time_frame_options_popup.dart';
import 'package:provider/provider.dart';

List<Widget> appBarActions(BuildContext context, Function updateSort,
    Function updateTime, String sort, String timeFrame, bool showTimeOption) {
  return [
    IconButton(
      icon: Icon(Icons.home),
      onPressed: () {
        Provider.of<FeedProvider>(context).setSubredditAndFetchWithClear("");
      },
    ),
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        print("search!");
      },
    ),
    PopupMenuButton(
      child: Icon(Icons.sort),
      itemBuilder: (BuildContext context) {
        return sortOptionsPopupMenu(context, sort);
      },
      onSelected: (String sort) => updateSort(sort),
    ),
    if (showTimeOption)
      PopupMenuButton(
        child: Icon(Icons.access_time),
        itemBuilder: (BuildContext context) {
          return timeFramePostsOptions(context, timeFrame);
        },
        onSelected: (String time) => updateTime(time),
      ),
    IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {
        print("options!");
      },
    ),
  ];
}
