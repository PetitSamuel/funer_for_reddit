import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funer_for_reddit/providers/comments_provider.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/providers/page_information_provider.dart';
import 'package:provider/provider.dart';

import 'package:funer_for_reddit/pages/home_page.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:funer_for_reddit/network/http_client_overrides.dart';
import 'package:funer_for_reddit/providers/authentificator_provider.dart';

void main() {
  HttpOverrides.global = new HttpClientOverrides();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        builder: (_) => AuthentificatorProvider(),
      ),
      ChangeNotifierProvider(
        builder: (_) => UserProvider(),
      ),
      ChangeNotifierProvider(
        builder: (_) => FeedProvider(),
      ),
      ChangeNotifierProvider(
        builder: (_) => CommentsProvider(),
      ),
      Provider(
        builder: (_) => PageInformationProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final String title = "Funer for Reddit";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomePage(title: title),
    );
  }
}
