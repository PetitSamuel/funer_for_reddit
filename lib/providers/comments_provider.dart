import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/shared/secure_storage_shared.dart';
import 'package:funer_for_reddit/models/comments/comment_model.dart';
import 'package:funer_for_reddit/shared/requests_shared.dart';

class CommentsProvider with ChangeNotifier {
  bool _isLoading = false;
  String after = "";
  List<CommentModel> comments;
  String sort;
  CommentsProvider();

  final SecureStorageShared storage = new SecureStorageShared();

  bool get isLoading => _isLoading;
  bool get hasComments => comments == null || comments.length > 0;

  clearComments() {
    this.after = "";
    this.comments = new List();
  }

  setSorting(String sort) {
    this.sort = sort;
  }

  Future<void> fetchComments(String sub, String article,
      {String sort = ""}) async {
    clearComments();
    if (sort != "") {
      this.sort = sort;
    }
    loading();
    if (sub.isEmpty ?? false || article.isEmpty ?? false) {
      return null;
    }

    String url = urlBuilder("$sub/comments/$article.json?sort=${this.sort}");
    String access = await this.storage.accessToken;
    var response = await buildRequestAndGet(url, accessToken: access);

    if (response.statusCode != 200) {
      print('error when calling comments');
    }
    var data = json.decode(response.body);

    this.comments = CommentModel.parseListToCommentsTree(data);
    this.stopLoading();
  }

  Future<bool> postComment(String comment, String fullname) async {
    if (!this.storage.signInStatus) {
      // not logged in, cannot comment
      // todo : show error message !
      return false;
    }
    String url = urlBuilder("api/comment");
    String access = await storage.accessToken;
    dynamic body = "thing_id=$fullname&api_type=json&text=$comment";

    var response =
        await buildRequestAndPost(url, body: body, accessToken: access);

    if (response.statusCode != 200) {
      print("here");
      // todo : handle error message
      return false;
    }
    var json = jsonDecode(response.body);
    var newComment =
        CommentModel.fromJson(json['json']['data']['things'][0]['data']);
    if (newComment != null) this.comments.add(newComment);
    this.notifyListeners();
    return true;
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
