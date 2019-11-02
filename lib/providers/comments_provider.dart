import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/helpers/secure_storage_helper.dart';
import 'package:funer_for_reddit/models/comments/comment_model.dart';
import 'package:funer_for_reddit/shared/requests.dart';

class CommentsProvider with ChangeNotifier {
  bool _isLoading = false;
  String subreddit = "";
  String postId = "";
  String after = "";
  List<CommentModel> comments;

  CommentsProvider();

  final SecureStorageHelper storage = new SecureStorageHelper();

  bool get isLoading => _isLoading;
  bool get hasComments => comments == null || comments.length > 0;

  setPostId(String s) {
    this.postId = s;
  }

  clearComments() {
    this.postId = "";
    this.subreddit = "";
    this.after = "";
    this.comments = new List();
  }

  Future<void> fetchComments(String sub, String article) async {
    loading();
    if (sub.isEmpty ?? false || article.isEmpty ?? false) {
      return null;
    }

    String url = urlBuilder("$sub/comments/$article.json");
    String access = await this.storage.accessToken;
    var response = await buildRequestAndGet(url, accessToken: access);

    if (response.statusCode != 200) {
      print('error when calling comments');
    }
    var data = json.decode(response.body);

    this.comments = CommentModel.parseListToCommentsTree(data);
    this.stopLoading();
  }

  loading() {
    _isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
