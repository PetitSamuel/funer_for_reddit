import 'package:flutter/material.dart';

/*
 *  A Popup menu with buttons.
 *  They are the sorting options for the feed.
*/
List<PopupMenuEntry<String>> sortOptionsPopupMenu(
    BuildContext context, String sort) {
  return <PopupMenuEntry<String>>[
    PopupMenuItem<String>(
      value: 'hot',
      child: ListTile(
        leading: Icon(Icons.hot_tub),
        title: Text('Hot'),
        enabled: 'hot' != sort,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<String>(
      value: 'best',
      child: ListTile(
        leading: Icon(Icons.keyboard_arrow_up),
        title: Text('Best'),
        enabled: 'best' != sort,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<String>(
      value: 'new',
      child: ListTile(
        leading: Icon(Icons.new_releases),
        title: Text('New'),
        enabled: 'new' != sort,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<String>(
      value: 'top',
      child: ListTile(
        leading: Icon(Icons.do_not_disturb_alt),
        title: Text('Top'),
        enabled: 'top' != sort,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<String>(
      value: 'controversial',
      child: ListTile(
        leading: Icon(Icons.do_not_disturb_alt),
        title: Text('Controversial'),
        enabled: 'controversial' != sort,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<String>(
      value: 'rising',
      child: ListTile(
        leading: Icon(Icons.do_not_disturb_alt),
        title: Text('Rising'),
        enabled: 'rising' != sort,
      ),
    ),
  ];
}
