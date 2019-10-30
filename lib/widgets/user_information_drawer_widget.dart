import 'package:flutter/material.dart';
import 'package:funer_for_reddit/providers/authentificator_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:provider/provider.dart';

Widget userProfiles(BuildContext context) {
  bool signedIn = Provider.of<AuthentificatorProvider>(context).signedIn;
  return Container(
    child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            title: Text(signedIn ? "Sign out" : "Sign in"),
            onTap: () {
              if (signedIn) {
                Provider.of<AuthentificatorProvider>(context).signOutUser();
                Provider.of<UserProvider>(context).clearData();
              } else {
                Provider.of<AuthentificatorProvider>(context)
                    .authenticateUser(context);
              }
            },
            trailing: Icon(Icons.power_settings_new),
          ),
          ListTile(
            title: Text('Refresh access token'),
            onTap: Provider.of<AuthentificatorProvider>(context).signedIn
                ? () {
                    Provider.of<AuthentificatorProvider>(context)
                        .performTokenRefresh();
                  }
                : null,
          ),
          ListTile(
            title: Text('Call /me'),
            onTap: Provider.of<AuthentificatorProvider>(context).signedIn
                ? () {
                    Provider.of<UserProvider>(context).loadUserInformation();
                  }
                : null,
          ),
        ]),
  );
}
