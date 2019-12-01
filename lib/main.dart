import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/subreddit_models/subscribed_subreddit_model.dart';
import 'package:funer_for_reddit/models/user_models/user_information_model.dart';
import 'package:funer_for_reddit/network/http_client_overrides.dart';
import 'package:funer_for_reddit/providers/auth_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:funer_for_reddit/widgets/drawer_body_logged_in.dart';
import 'package:funer_for_reddit/widgets/drawer_header_logged_in.dart';
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
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  UserInformationModel get user => Provider.of<UserProvider>(context).user;
  List<SubredditModel> get subs =>
      Provider.of<UserProvider>(context).subreddits;

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
                    onTap: () => login(context),
                  ),
          ),
          if (signedIn) DrawerBodyLoggedIn()
        ]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*
            testing stuff : 
            FlatButton(
              child: Text("test refresh token"),
              onPressed: () async {
                print(Provider.of<AuthProvider>(context).refreshToken);
                print(await Provider.of<AuthProvider>(context).accessToken);
                print(Provider.of<AuthProvider>(context).lastTokenRefresh);
                print(Provider.of<AuthProvider>(context).signedIn);
                print(Provider.of<AuthProvider>(context).needsTokenRefresh());
                await Provider.of<AuthProvider>(context).performTokenRefresh();
                print(await Provider.of<AuthProvider>(context).accessToken);
                print(Provider.of<AuthProvider>(context).lastTokenRefresh);
              },
            )
            */
          ],
        ),
      ),
    );
  }
}
