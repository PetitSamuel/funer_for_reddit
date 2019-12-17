import 'package:flutter/material.dart';
import 'package:funer_for_reddit/app_actions_manager.dart';
import 'package:funer_for_reddit/models/models_export.dart';
import 'package:funer_for_reddit/shared/constants.dart';
import 'package:funer_for_reddit/widgets/feed_body_item_information_widget.dart';
import 'package:share/share.dart';

Widget feedBodyItem(BuildContext context, PostModel post) {
  String authorNamePrefixed = "u/" + post.author;
  return Container(
    child: InkWell(
      onTap: () => pushPostPage(context, post),
      // todo : send call for saving post
      onDoubleTap: () => print("save post"),
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
                  onPressed: () {
                    pushSubredditPage(
                        context, post.subredditNamePrefixed + "/");
                  },
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
              feedBodyItemInformation(post),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_upward,
                      color: post.likes == true ? Colors.orange : Colors.white,
                    ),
                    onPressed: () {
                      votePost(context, post, UPVOTE_DIR);
                      print("up");
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_downward,
                      color: post.likes == false ? Colors.blue : Colors.white,
                    ),
                    onPressed: () {
                      print("down");
                      votePost(context, post, DOWNVOTE_DIR);
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
    ),
  );
}
