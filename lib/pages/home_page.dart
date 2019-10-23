import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/Subreddit.dart';
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
        child: subreddits(),
      ),
    );
  }

  Widget subreddits() {
    return Consumer<UserProvider>(
          builder: (BuildContext context, UserProvider model, _) {
            if(model.signedIn) {
              if(model.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                itemBuilder: (context, int index) {
                  Subreddit current = model.subscribedSubReddits[index]; 
                  String iconUrl = model.subscribedSubReddits[index].community_icon;
                  return ListTile(
                    title: Text(current.display_name),
                    leading: iconUrl.isEmpty ? Icon(Icons.error_outline)  : CircleAvatar(
                      backgroundImage: NetworkImage(iconUrl),
                    ),
                    onTap: () {
                      print(current.url);
                    },
                  );
                },
                itemCount: model.subscribedSubReddits.length,
              );
              }
            } else {
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
          },
        );
  }
}
