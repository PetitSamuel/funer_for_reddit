import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/app_actions_manager.dart';
import 'package:funer_for_reddit/models/models_export.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/widgets/feed/feed_body_item.dart';
import 'package:provider/provider.dart';

/*
  Display the feed by building a listview of post items.
  Handles error scenarios & loading scenarios.
*/
class FeedBody extends StatelessWidget {
  FeedBody();

  @override
  Widget build(BuildContext context) {
    List<PostModel> posts = Provider.of<FeedProvider>(context).posts;
    bool loading = Provider.of<FeedProvider>(context).loading;

    // error when loading
    if (!loading && (posts == null || posts.isEmpty)) {
      return Container(
        child: ListTile(
          leading: Icon(Icons.refresh),
          title: Text("Error when loading posts"),
          subtitle: Text("Click to try again"),
          onTap: () => loadPosts(context),
        ),
      );
    }

    return Column(children: <Widget>[
      Container(
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, int index) {
            return feedBodyItem(context, posts[index]);
          },
          itemCount: posts.length,
        ),
      ),
      if (loading)
        Center(
          child: CircularProgressIndicator(),
        )
    ]);
  }
}
