import 'package:flutter/material.dart';
import 'package:funer_for_reddit/widgets/subredditsList.dart';
import 'package:provider/provider.dart';

import 'package:funer_for_reddit/providers/authentificator_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String code;
  String authToken;
  String refreshToken;
  bool _showUserProfiles = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Provider.of<AuthentificatorProvider>(context).isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child:
                        Provider.of<AuthentificatorProvider>(context).signedIn
                            ? Text('Signed in')
                            : Text('Sign in on the left'),
                  ),
                  RaisedButton(
                    child: Text('Refresh access token'),
                    onPressed:
                        Provider.of<AuthentificatorProvider>(context).signedIn
                            ? () {
                                Provider.of<AuthentificatorProvider>(context)
                                    .performTokenRefresh();
                              }
                            : null,
                  ),
                  RaisedButton(
                    child: Text('Call /me'),
                    onPressed:
                        Provider.of<AuthentificatorProvider>(context).signedIn
                            ? () {
                                Provider.of<UserProvider>(context)
                                    .loadUserInformation();
                              }
                            : null,
                  ),
                ],
              ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              child: DrawerHeader(
                  child: user(),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(0.0)),
                  height: 65,
            ),
            _showUserProfiles ? userProfiles() : subreddits(),
          ],
        ),
      ),
    );
  }

  Widget userProfiles() {
    bool signedIn = Provider.of<AuthentificatorProvider>(context).signedIn;
    return 
        ListTile(
      title: Text(signedIn ? "Sign out" : "Sign in"),
      onTap: () {
        if (signedIn) {
          Provider.of<AuthentificatorProvider>(context).signOutUser();
        } else {
          Provider.of<AuthentificatorProvider>(context).authenticateUser(context);
          setState(() {
            _showUserProfiles = false;
          });
        }
      },
      trailing: Icon(Icons.power_settings_new),
    );
  }

  Widget user() {
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
              onExpansionChanged: (bool expanding) => setState(() => this._showUserProfiles = expanding),
              leading: CircleAvatar(child: Image.network(model.user.icon_img)),
              title: Text(model.user.display_name_prefixed),
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
}
