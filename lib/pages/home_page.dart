import 'package:flutter/material.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/widgets/drawer/drawer_header.dart';
import 'package:funer_for_reddit/widgets/feed/feed_body_widget.dart';
import 'package:funer_for_reddit/widgets/popup_buttons/sort_options_popup_menu.dart';
import 'package:funer_for_reddit/widgets/drawer/subreddit_drawer_body_widget.dart';
import 'package:funer_for_reddit/widgets/popup_buttons/time_frame_options_popup.dart';
import 'package:funer_for_reddit/widgets/drawer/user_information_drawer_widget.dart';
import 'package:provider/provider.dart';

import 'package:funer_for_reddit/providers/authentificator_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showUserProfiles = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("reload");
        Provider.of<FeedProvider>(context).fetchPostsListing();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<FeedProvider>(context).isLoading) _showUserProfiles = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Provider.of<FeedProvider>(context)
                  .setSubredditAndFetchWithClear("");
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
              return sortOptionsPopupMenu(context, this.sort);
            },
            onSelected: (String sort) => updateSort(sort),
          ),
          if (this.showTimeOption)
            PopupMenuButton(
              child: Icon(Icons.access_time),
              itemBuilder: (BuildContext context) {
                return timeFramePostsOptions(context, this.timeFrame);
              },
              onSelected: (String time) => updateTime(time),
            ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              print("options!");
            },
          ),
        ],
      ),
      body: Center(
        child: Provider.of<AuthentificatorProvider>(context).isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  feedBody(Provider.of<FeedProvider>(context).posts,
                      _scrollController),
                  if (Provider.of<FeedProvider>(context).isLoading)
                    Center(child: LinearProgressIndicator()),
                ],
              ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              child: DrawerHeader(
                  child: drawerHeader(updateShowUserProfile),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(0.0)),
              height: 65,
            ),
            if (!_showUserProfiles)
              Container(
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    ListTile(
                      title: Text("Home page"),
                      leading: Icon(
                        Icons.home,
                        color:
                            Provider.of<FeedProvider>(context).subreddit == ""
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
              ),
            _showUserProfiles
                ? userInformationDrawerHeader(context, updateShowUserProfile)
                : subredditDrawerBody(),
          ],
        ),
      ),
    );
  }

  updateShowUserProfile(bool value) {
    setState(() {
      _showUserProfiles = value;
    });
  }

  goHomePage() {
    Provider.of<FeedProvider>(context).setSubredditAndFetchWithClear("");
    Navigator.pop(context);
  }

  updateSort(String sort) {
    Provider.of<FeedProvider>(context).setSort(sort);
    Provider.of<FeedProvider>(context).fetchPostsListing();
  }

  updateTime(String time) {
    Provider.of<FeedProvider>(context).setTimeframe(time);
    Provider.of<FeedProvider>(context).fetchPostsListing();
  }

  String get sort => Provider.of<FeedProvider>(context).sort;
  String get timeFrame => Provider.of<FeedProvider>(context).timeframe;
  bool get showTimeOption => Provider.of<FeedProvider>(context).showTimeOption;
}
