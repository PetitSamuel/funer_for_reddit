import 'package:flutter/material.dart';
import 'package:funer_for_reddit/app_state_manager.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:share/share.dart';

Widget feedBodyItem(BuildContext context, PostModel post) {
  String authorNamePrefixed = "u/" + post.author;
  return InkWell(
    onTap: () => pushPostPage(context, post),
    onDoubleTap: () => print("save post "),
    child: Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: FlatButton(
                child: Text(post.subredditNamePrefixed),
                onPressed: () => pushSubredditPage(
                    context, post.subredditNamePrefixed + "/"),
              ),
            ),
            Expanded(
              flex: 2,
              child: FlatButton(
                child: Text(authorNamePrefixed),
                onPressed: () => print(authorNamePrefixed),
              ),
            )
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(post.title,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              margin: EdgeInsets.only(bottom: 8),
            ),
            if (post.selftext.isNotEmpty)
              Text(
                post.selftext,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_upward,
                    // color: upArrowColor,
                  ),
                  onPressed: () {
                    print("up");
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_downward,
                    //  color: downArrowColor,
                  ),
                  onPressed: () {
                    print("down boiz");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    print("push");
                    // pushPostPage(context, post);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () async =>
                      await Share.share('www.reddit.com${post.permalink}'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
