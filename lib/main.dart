import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:funer_for_reddit/providers/authentificator_provider.dart';

void main() =>
  runApp(ChangeNotifierProvider(
    builder: (_) => AuthentificatorProvider(),
    child: MyApp(),
  ));

class MyApp extends StatelessWidget {
  final String title = "Funer for Reddit";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: title),
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
  String code;
  String authToken;
  String refreshToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Provider.of<AuthentificatorProvider>(context).isLoading ? 
          CircularProgressIndicator() : 
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Provider.of<AuthentificatorProvider>(context).signedIn
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
              ],
            ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Provider.of<AuthentificatorProvider>(context).signedIn
                ? ListTile(
                    title: Text('Sign out of reddit'),
                    leading: Icon(Icons.zoom_out_map),
                    onTap: () {
                      Provider.of<AuthentificatorProvider>(context).signOutUser();
                    },
                  )
                : ListTile(
                    title: Text('Sign into reddit'),
                    leading: Icon(Icons.airline_seat_flat),
                    onTap: () {
                      Provider.of<AuthentificatorProvider>(context).authenticateUser(context);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
