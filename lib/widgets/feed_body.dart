import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/app_actions_manager.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/providers/feed_provider.dart';
import 'package:funer_for_reddit/widgets/feed_body_item.dart';
import 'package:provider/provider.dart';

class FeedBody extends StatelessWidget {
  FeedBody();

  @override
  Widget build(BuildContext context) {
    List<PostModel> posts = Provider.of<FeedProvider>(context).posts;
    bool loading = Provider.of<FeedProvider>(context).loading;

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
