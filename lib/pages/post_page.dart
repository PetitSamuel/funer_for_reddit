import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:funer_for_reddit/models/models_export.dart';
import 'package:funer_for_reddit/widgets/comment/comment_tree.dart';
import 'package:funer_for_reddit/widgets/post/post_bottom_actions_widget.dart';
import 'package:funer_for_reddit/widgets/post/post_header_content_widget.dart';
import 'package:funer_for_reddit/widgets/post/post_metrics_information_widget.dart';
import 'package:html_unescape/html_unescape_small.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key, this.post}) : super(key: key);

  final PostModel post;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String get commentSort => "hot";

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var post = widget.post;
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
            /*
            PopupMenuButton(
              child: Icon(Icons.sort),
              itemBuilder: (BuildContext context) {
                return sortOptionsCommentsPopupMenu(context, this.commentSort);
              },
              onSelected: (String sort) => updateCommentSort(sort),
            ),
            */
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
                                  /* bool wasPosted =
                                      await Provider.of<CommentsProvider>(
                                              context)
                                          .postComment(comment, post.name);
                                  if (wasPosted) post.numComments++;
                                  */
                                  print("post: " + comment);
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
                postHeaderContent(post),
                feedBodyItemInformation(post),
                Html(
                  data:
                      """${HtmlUnescape().convert(post.selftextHtml ?? "")}""",
                ),
                Divider(),
                postBottomActions(context, post),
                CommentTree(post),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
