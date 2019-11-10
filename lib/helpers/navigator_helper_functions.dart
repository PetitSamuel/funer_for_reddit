import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';
import 'package:funer_for_reddit/pages/post_page.dart';
import 'package:funer_for_reddit/providers/comments_provider.dart';
import 'package:funer_for_reddit/providers/page_information_provider.dart';
import 'package:provider/provider.dart';

/*
 * Helper functions for navigator management.
*/
pushPostPage(BuildContext context, PostModel post) {
  Provider.of<PageInformationProvider>(context).changeCurrentpage("post");
  Provider.of<CommentsProvider>(context).setSorting("best");
  Provider.of<CommentsProvider>(context)
      .fetchComments(post.subredditNamePrefixed, post.id);
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostPage(post: post),
      )).then((value) {
    Provider.of<PageInformationProvider>(context).changeCurrentpage("home");
    Provider.of<CommentsProvider>(context).clearComments();
  });
}
