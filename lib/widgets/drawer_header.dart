import 'package:flutter/material.dart';
import 'package:funer_for_reddit/providers/authentificator_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:provider/provider.dart';

Widget drawerHeader(_changeDisplayState) {
  return Consumer<UserProvider>(
    builder: (BuildContext context, UserProvider model, _) {
      if (model.isLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (!model.signedIn) {
        return SafeArea(
          child: ListTile(
            title: Text('Sign into reddit'),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(Icons.person_outline),
            ),
            onTap: () {
              Provider.of<AuthentificatorProvider>(context)
                  .authenticateUser(context);
            },
          ),
        );
      }
      return ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          ExpansionTile(
            onExpansionChanged: (bool expanding) =>
                _changeDisplayState(expanding),
            leading: CircleAvatar(child: Image.network(model.user.iconImg)),
            title: Text(model.user.displayNamePrefixed),
            children: <Widget>[
              ListTile(
                trailing: Icon(Icons.power_settings_new),
              ),
            ],
          ),
        ],
      );
    },
  );
}
