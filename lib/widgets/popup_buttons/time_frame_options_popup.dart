import 'package:flutter/material.dart';

/*
 *  A Popup menu with buttons.
 *  They are the options to select a 
 *  time frame for certain feeds posts sorting. 
*/
List<PopupMenuEntry<String>> timeFramePostsOptions(
    BuildContext context, String time) {
  return <PopupMenuEntry<String>>[
    PopupMenuItem<String>(
      value: 'hour',
      child: ListTile(
        leading: Icon(Icons.hot_tub),
        title: Text('Hour'),
        enabled: 'hour' != time,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<String>(
      value: 'day',
      child: ListTile(
        leading: Icon(Icons.keyboard_arrow_up),
        title: Text('Day'),
        enabled: 'day' != time,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<String>(
      value: 'week',
      child: ListTile(
        leading: Icon(Icons.new_releases),
        title: Text('Week'),
        enabled: 'week' != time,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<String>(
      value: 'month',
      child: ListTile(
        leading: Icon(Icons.do_not_disturb_alt),
        title: Text('Month'),
        enabled: 'month' != time,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<String>(
      value: 'year',
      child: ListTile(
        leading: Icon(Icons.do_not_disturb_alt),
        title: Text('Year'),
        enabled: 'year' != time,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<String>(
      value: 'all',
      child: ListTile(
        leading: Icon(Icons.do_not_disturb_alt),
        title: Text('All'),
        enabled: 'all' != time,
      ),
    ),
    const PopupMenuDivider(),
  ];
}
