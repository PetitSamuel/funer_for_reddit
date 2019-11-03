import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/providers/comments_provider.dart';
import 'package:funer_for_reddit/widgets/comments/comments_tree_widget.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key, this.post}) : super(key: key);

  final PostModel post;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    var post = widget.post;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Comments'),
          actions: <Widget>[
            Container(
              child: Center(child: Text("sorting")),
              margin: EdgeInsets.only(right: 12),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => print("search"),
            ),
            IconButton(
              icon: Icon(Icons.sort),
              onPressed: () => print("sort"),
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => print("setting"),
            ),
          ],
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
            child: ListView(
              children: <Widget>[
                Text(
                  post.title + '\n',
                  softWrap: true,
                  style: TextStyle(fontSize: 20),
                ),
                Text(post.subredditNamePrefixed),
                Text(post.selftext),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_upward),
                      onPressed: () => print("upvote"),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_downward),
                      onPressed: () => print("downward"),
                    ),
                    IconButton(
                      icon: Icon(Icons.star),
                      onPressed: () => print("starred"),
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () => print("comments"),
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () => print("share"),
                    ),
                  ],
                ),
                if (Provider.of<CommentsProvider>(context).isLoading)
                  Center(
                    child: LinearProgressIndicator(),
                  ),
                if (Provider.of<CommentsProvider>(context).hasComments)
                  commentsTree(
                      context, Provider.of<CommentsProvider>(context).comments),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
