import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/providers/comments_provider.dart';
import 'package:funer_for_reddit/widgets/comments/comments_tree_widget.dart';
import 'package:funer_for_reddit/widgets/feed/feed_body_item_information_widget.dart';
import 'package:html_unescape/html_unescape.dart';
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
    var imgsrc = PostModel.getPreviewImageSource(post);
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (imgsrc != null)
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 12, top: 8),
                          child: Image.network(
                            HtmlUnescape().convert(imgsrc.url),
                          ),
                        ),
                        flex: 4,
                      ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 12, top: 4),
                        child: Text(
                          post.title + '\n',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      flex: 12,
                    ),
                  ],
                ),
                feedBodyItemInformation(context, post),
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
