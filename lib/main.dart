import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funer_for_reddit/network/http_client_overrides.dart';
import 'package:funer_for_reddit/providers/actions_provider.dart';
import 'package:funer_for_reddit/providers/auth_provider.dart';
import 'package:funer_for_reddit/providers/comment_provider.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:funer_for_reddit/widgets/drawer/app_drawer.dart';
import 'package:funer_for_reddit/widgets/feed/feed_body.dart';
import 'package:provider/provider.dart';

import 'package:funer_for_reddit/app_actions_manager.dart';

void main() {
  // set custom http client
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
  @override
  void initState() {
    super.initState();

    // Trick which somehow works (wait for startup builds to finish) - is this safe?
    Future.delayed(Duration.zero, () {
      onStartup(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: <Widget>[
          FeedBody(),
        ],
      ),
    );
  }
}
