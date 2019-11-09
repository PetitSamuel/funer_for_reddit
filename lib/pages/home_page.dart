import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/subreddit_models/subscribed_subreddit_model.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:funer_for_reddit/widgets/app_bar/app__bar_actions_widget.dart';
import 'package:funer_for_reddit/widgets/drawer/drawer_default_feed_options_widget.dart';
import 'package:funer_for_reddit/widgets/drawer/drawer_header.dart';
import 'package:funer_for_reddit/widgets/feed/feed_body_widget.dart';
import 'package:funer_for_reddit/widgets/drawer/subreddit_drawer_body_widget.dart';
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
        actions: appBarActions(context, updateSort, updateTime, this.sort,
            this.timeFrame, this.showTimeOption),
      ),
      body: Center(
        child: Provider.of<AuthentificatorProvider>(context).isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Builder(
                    builder: (context) {
                      SubredditModel sub =
                          this.subredditInformation(this.currentSubredditName);
                      if (sub == null) return Container();
                      print(sub.bannerSize);
                      return Container(
                        child: DecoratedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                child: 
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    child: Image.network(sub.iconImg),
                                    radius: 20,
                                  ),
                                  Text(
                                    "  " + sub.displayName,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ],
                              ),),
                              // todo: change color of text based on image or move this down
                              Container(
                                child: Text(
                                sub.publicDescription,
                                style: TextStyle(
                                  color: Colors.black
                                ),
                              ),
                              margin: EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
                              )
                            ],
                          ),
                          // todo: fix this to handle null / non valid banners
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(sub.bannerImg),
                                  fit: BoxFit.fill)),
                        ),
                      );
                    },
                  ),
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
              drawerDefaultFeedOptions(context, goHomePage),
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
  String get currentSubredditName =>
      Provider.of<FeedProvider>(context).subreddit;
  String get timeFrame => Provider.of<FeedProvider>(context).timeframe;
  bool get showTimeOption => Provider.of<FeedProvider>(context).showTimeOption;
  SubredditModel subredditInformation(String sub) {
    if (sub == null || sub.isEmpty) {
      return null;
    }
    int len = sub.length;
    String subreddit = sub.substring(1, len - 1).toLowerCase();
    var subs = Provider.of<UserProvider>(context).subscribedSubReddits;
    SubredditModel current = subs.firstWhere(
        (val) => val.displayNamePrefixed.toLowerCase() == subreddit,
        orElse: null);
    return current;
  }
}
