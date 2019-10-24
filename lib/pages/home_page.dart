import 'package:flutter/material.dart';
import 'package:funer_for_reddit/widgets/UserDrawerHeader.dart';
import 'package:funer_for_reddit/widgets/subredditsList.dart';
import 'package:funer_for_reddit/widgets/user_information_drawer_widget.dart';
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
                  child: userDrawerHeader(updateShowUserProfile),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(0.0)),
              height: 65,
            ),
            _showUserProfiles
                ? userProfiles(context)
                : drawerSubredditsListView(),
          ],
        ),
      ),
    );
  }

  updateShowUserProfile(bool value) {
    setState(() {
      _showUserProfiles = value;
    });
  }
}
