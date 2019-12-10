import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/app_state_manager.dart';
import 'package:funer_for_reddit/models/subreddit_models/subscribed_subreddit_model.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:funer_for_reddit/widgets/subreddit_drawer_body_item.dart';
import 'package:provider/provider.dart';

// The card for a single section. Displays the section's gradient and background image.
class DrawerBodyLoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<SubredditModel> subs = Provider.of<UserProvider>(context).subreddits;
    bool isLoadingSubs = Provider.of<UserProvider>(context).loadingSubs;

    if (!isLoadingSubs && (subs == null || subs.isEmpty)) {
      return Container(
        child: ListTile(
          leading: Icon(Icons.refresh),
          title: Text("Error when loading subreddits"),
          subtitle: Text("Click to try again"),
          onTap: () => loadUserSubs(context),
        ),
      );
    }

    return Column(children: <Widget>[
      Container(
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, int index) {
            return subredditDrawerBodyItem(context, subs[index]);
          },
          itemCount: subs.length,
        ),
      ),
      if (isLoadingSubs)
        Center(
          child: CircularProgressIndicator(),
        )
    ]);
  }
}