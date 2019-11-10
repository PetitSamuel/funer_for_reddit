import 'package:flutter/material.dart';

/*
 *  A Popup menu with buttons.
 *  They are the sorting options for the feed.
*/
List<PopupMenuEntry<String>> sortOptionsCommentsPopupMenu(
    BuildContext context, String sort) {
  return <PopupMenuEntry<String>>[
    PopupMenuItem<String>(
      value: 'confidence',
      child: ListTile(
        leading: Icon(Icons.hot_tub),
        title: Text('Best'),
        enabled: 'confidence' != sort,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<String>(
      value: 'top',
      child: ListTile(
        leading: Icon(Icons.keyboard_arrow_up),
        title: Text('Top'),
        enabled: 'top' != sort,
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
      value: 'controversial',
      child: ListTile(
        leading: Icon(Icons.do_not_disturb_alt),
        title: Text('Controversial'),
        enabled: 'controversial' != sort,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<String>(
      value: 'old',
      child: ListTile(
        leading: Icon(Icons.do_not_disturb_alt),
        title: Text('Old'),
        enabled: 'old' != sort,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<String>(
      value: 'qa',
      child: ListTile(
        leading: Icon(Icons.do_not_disturb_alt),
        title: Text('Q&A'),
        enabled: 'qa' != sort,
      ),
    ),
  ];
}
