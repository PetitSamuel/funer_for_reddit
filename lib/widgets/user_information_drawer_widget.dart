import 'package:flutter/material.dart';
import 'package:funer_for_reddit/providers/authentificator_provider.dart';
import 'package:provider/provider.dart';

Widget userProfiles(BuildContext context) {
  bool signedIn = Provider.of<AuthentificatorProvider>(context).signedIn;
  return ListTile(
    title: Text(signedIn ? "Sign out" : "Sign in"),
    onTap: () {
      if (signedIn) {
        Provider.of<AuthentificatorProvider>(context).signOutUser();
      } else {
        Provider.of<AuthentificatorProvider>(context).authenticateUser(context);
      }
    },
    trailing: Icon(Icons.power_settings_new),
  );
}
