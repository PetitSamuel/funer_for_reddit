import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/actions/auth_actions.dart';
import 'package:funer_for_reddit/pages/subreddit_page.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:provider/provider.dart';

/*
  File manages required actions for the feed.
  If a user action requires the app to load new posts,
  it can simply call the helper method here, the method will then delegate 
  all the required actions to the providers.
*/

/*
  Load new posts without pushing a new subreddit page.
*/
updateSubredditNoNewPage(BuildContext context, String subreddit) async {
  String currentSub = Provider.of<FeedProvider>(context).subreddit;
  if (currentSub == subreddit.toLowerCase()) {
    print("not pushing !");
    return;
  }
  loadPosts(context, sub: subreddit);
}

/*
  Push a new subreddit page to the navigator stack. 
  Launch load posts actions.
*/
pushSubredditPage(BuildContext context, String subreddit) async {
  String currentSub = Provider.of<FeedProvider>(context).subreddit;
  if (currentSub == subreddit.toLowerCase()) {
    print("not pushing !");
    return;
  }
  String token = await getAccessToken(context);
  Provider.of<FeedProvider>(context).fetchPosts(subreddit, accessToken: token);
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubredditPage(subreddit: subreddit),
      )).then((value) {
    /*
      todo : maybe we dont need to reload every time. Should find a system to return back to same page
      maybe through a stack of posts & current post tracker
    */
    loadPosts(context);
  });
}

/*
  Launch load posts actions. Loads home page by default.
*/
loadPosts(BuildContext context, {String sub = ""}) async {
  String token = await getAccessToken(context);
  Provider.of<FeedProvider>(context).fetchPosts(sub, accessToken: token);
}
