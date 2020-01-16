import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/app_actions_manager.dart';
import 'package:funer_for_reddit/widgets/drawer/drawer_body_logged_in.dart';
import 'package:funer_for_reddit/widgets/drawer/drawer_header_logged_in.dart';

/*
  Main drawer widget for the app. Includes logged in & out displaying. 
*/
class AppDrawer extends StatelessWidget {
  AppDrawer();

  @override
  Widget build(BuildContext context) {
    bool signedIn = isSignedIn(context);

    return Drawer(
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
                  title: Text("Sign in"),
                  onTap: () {
                    login(context);
                  },
                ),
        ),
        // options to show even if not logged in
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            // todo : add more options here
            ListTile(
              title: Text("all"),
              leading: Icon(Icons.star),
              onTap: () {
                updateSubredditNoNewPage(context, "r/all/");
              },
            ),
          ],
        ),
        if (signedIn)
          DrawerBodyLoggedIn()
      ]),
    );
  }
}
