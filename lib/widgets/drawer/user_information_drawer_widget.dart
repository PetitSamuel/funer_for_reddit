import 'package:flutter/material.dart';
import 'package:funer_for_reddit/providers/authentificator_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:provider/provider.dart';

/*
 * Body of the drawer when the header is expanded.
 * Contains sign out button and debugging buttons for now.
*/
Widget userInformationDrawerHeader(
    BuildContext context, Function _changeDisplayState) {
  return Container(
    child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            title: Text("Sign out"),
            onTap: () {
              Provider.of<AuthentificatorProvider>(context).signOutUser();
              Provider.of<UserProvider>(context).clearData();
              _changeDisplayState(false);
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
