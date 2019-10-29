import 'package:flutter/material.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/widgets/drawer_header.dart';
import 'package:funer_for_reddit/widgets/feed.dart';
import 'package:funer_for_reddit/widgets/subreddits_list_drawer_widget.dart';
import 'package:funer_for_reddit/widgets/user_information_drawer_widget.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Provider.of<AuthentificatorProvider>(context).isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Provider.of<AuthentificatorProvider>(context).signedIn
                      ? subredditFeedListView(
                          Provider.of<FeedProvider>(context).posts)
                      : Center(child: Text("sign in!")),
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
            _showUserProfiles
                ? userProfiles(context)
                : drawerSubredditsListView(),
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
}
