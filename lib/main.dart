import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funer_for_reddit/network/http_client_overrides.dart';
import 'package:funer_for_reddit/providers/auth_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
          DrawerHeader(
            child: 
                loggedIn(context) ? 
                // show logged in widget
                ListTile(
                  title: Text("welcome."),
                  onTap: () => signout(context),
                ) :
                // show log in button
                ListTile(
                  leading: isAuthLoading(context) ? CircularProgressIndicator() : Icon(Icons.account_circle),
                  title: Text("log in mate."),
                  onTap: () => login(context),
                ),
              
          ),
        ]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
