import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/models/Subreddit.dart';
import 'package:funer_for_reddit/providers/authentificator_provider.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:provider/provider.dart';

Widget subreddits() {
    return Consumer<UserProvider>(
      builder: (BuildContext context, UserProvider model, _) {
        if (model.signedIn) {
          if (model.subscribedSubReddits.length == 0)
            return SafeArea(
                child: Container(color: Colors.white // This is optional
                    ));
          if (model.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, int index) {
                  Subreddit current = model.subscribedSubReddits[index];
                  String iconUrl =
                      model.subscribedSubReddits[index].community_icon;
                  return ListTile(
                    title: Text(current.display_name),
                    leading: iconUrl.isEmpty
                        ? Icon(Icons.error_outline)
                        : CircleAvatar(
                            backgroundImage: NetworkImage(iconUrl),
                          ),
                    onTap: () {
                      print(current.url);
                    },
                  );
                },
                itemCount: model.subscribedSubReddits.length,
              ),
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