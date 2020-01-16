import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/app_actions_manager.dart';
import 'package:funer_for_reddit/models/models_export.dart';
import 'package:funer_for_reddit/providers/comment_provider.dart';
import 'package:funer_for_reddit/widgets/comment/single_comment_card_widget.dart';
import 'package:provider/provider.dart';

// The card for a single section. Displays the section's gradient and background image.
class CommentTree extends StatelessWidget {
  CommentTree(this.post);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    List<CommentModel> coms = Provider.of<CommentProvider>(context).comments;
    bool loadingComments = Provider.of<CommentProvider>(context).loading;

    if (!loadingComments && (coms == null || coms.isEmpty)) {
      return Container(
        child: ListTile(
          leading: Icon(Icons.refresh),
          title: Text("Error when loading comments"),
          subtitle: Text("Click to try again"),
          onTap: () => loadComments(context, post),
        ),
      );
    }

    return Column(
      children: <Widget>[
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            CommentModel item = coms[index];
            return singleCommentCardWidget(item);
          },
          itemCount: coms.length,
        ),
        if (loadingComments)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
