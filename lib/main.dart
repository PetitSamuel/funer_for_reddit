import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/subreddit_models/subscribed_subreddit_model.dart';
import 'package:funer_for_reddit/models/user_models/user_information_model.dart';
import 'package:funer_for_reddit/network/http_client_overrides.dart';
import 'package:funer_for_reddit/providers/actions_provider.dart';
import 'package:funer_for_reddit/providers/auth_provider.dart';
import 'package:funer_for_reddit/providers/comment_provider.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:funer_for_reddit/widgets/drawer_body_logged_in.dart';
import 'package:funer_for_reddit/widgets/drawer_header_logged_in.dart';
import 'package:funer_for_reddit/widgets/feed_body.dart';
import 'package:provider/provider.dart';

import 'app_state_manager.dart';

void main() {
  HttpOverrides.global = new HttpClientOverrides();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => FeedProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CommentProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ActionsProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Funer for Reddit',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Funer for Reddit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool get hasSubs => Provider.of<UserProvider>(context).hasSubs;
  bool get hasUser => Provider.of<UserProvider>(context).hasUser;

  bool firstLoad = true;

  UserInformationModel get user => Provider.of<UserProvider>(context).user;
  List<SubredditModel> get subs =>
      Provider.of<UserProvider>(context).subreddits;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      onStartup(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool signedIn = loggedIn(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(shrinkWrap: true, children: <Widget>[
          DrawerHeader(
            child: signedIn
                ?
                // show logged in widget
                DrawerHeaderLoggedIn()
                :
                // show log in button
                ListTile(
                    leading: isAuthLoading(context)
                        ? CircularProgressIndicator()
                        : Icon(Icons.account_circle),
                    title: Text("log in mate."),
                    onTap: () {
                      this.firstLoad = false;
                      login(context);
                    },
                  ),
          ),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              ListTile(
                title: Text("all"),
                leading: Icon(Icons.star),
                onTap: () {
                  updateSubredditNoNewPage(context, "r/all/");
                },
              ),
            ],
          ),
          if (signedIn) DrawerBodyLoggedIn()
        ]),
      ),
      body: ListView(
        children: <Widget>[
          FeedBody(),
        ],
      ),
    );
  }
}
