import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funer_for_reddit/helpers/html_convert.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/providers/comments_provider.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/widgets/comments/comments_tree_widget.dart';
import 'package:funer_for_reddit/widgets/feed/feed_body_item_information_widget.dart';
import 'package:funer_for_reddit/widgets/popup_buttons/sort_options_comments.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key, this.post}) : super(key: key);

  final PostModel post;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String get commentSort => Provider.of<CommentsProvider>(context).sort;

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

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
              child: Center(child: Text(this.commentSort)),
              margin: EdgeInsets.only(right: 12),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => print("search"),
            ),
            PopupMenuButton(
              child: Icon(Icons.sort),
              itemBuilder: (BuildContext context) {
                return sortOptionsCommentsPopupMenu(context, this.commentSort);
              },
              onSelected: (String sort) => updateCommentSort(sort),
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => print("setting"),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          autofocus: true,
          isExtended: true,
          child: Icon(Icons.add),
          mini: true,
          onPressed: () {
            _textController.clear();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Post a comment!"),
                        Flexible(
                          child: Container(
                            height: 200,
                            width: 250,
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              //todo : add controller
                              controller: _textController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 10,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                color: Colors.grey,
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _textController.clear();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text("Post"),
                                onPressed: () async {
                                  String comment = _textController.text.trim();
                                  if (comment.isEmpty) {
                                    // can't post empty
                                    return null;
                                  }
                                  // todo get text from controller here and put it into method
                                  bool wasPosted =
                                      await Provider.of<CommentsProvider>(
                                              context)
                                          .postComment(comment, post.name);
                                  if (wasPosted) post.numComments++;
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
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
                            htmlUnescapeConvert(imgsrc.url),
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
                      color: post.likes == true
                          ? Colors.orangeAccent
                          : Colors.white,
                      icon: Icon(Icons.arrow_upward),
                      onPressed: () {
                        Provider.of<FeedProvider>(context)
                            .votePost(post.name, "up", post.likes);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_downward),
                      color: post.likes == false ? Colors.blue : Colors.white,
                      onPressed: () {
                        Provider.of<FeedProvider>(context)
                            .votePost(post.name, "down", post.likes);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.star),
                      onPressed: () => print("starred"),
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () async =>
                          await Share.share('www.reddit.com${post.permalink}'),
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

  updateCommentSort(String sort) {
    if (this.commentSort == sort) return;
    //post.subredditNamePrefixed, post.id
    String subredditName = widget.post.subredditNamePrefixed;
    String postId = widget.post.id;
    Provider.of<CommentsProvider>(context)
        .fetchComments(subredditName, postId, sort: sort);
  }
}
