import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:funer_for_reddit/models/comments/comment_model.dart';
import 'package:funer_for_reddit/shared/requests_shared.dart';

class CommentProvider with ChangeNotifier {
  bool _isLoading = false;
  String after = "";
  List<CommentModel> comments;
  String sort = "";

  bool get loading => _isLoading;
  bool get hasComments => comments == null || comments.length > 0;

  CommentProvider();

  clearComments() {
    this.after = "";
    this.comments = new List();
  }

  setSorting(String sort) {
    this.sort = sort;
  }

  Future<void> fetchComments(String sub, String article,
      {String sort = "", String access = ""}) async {
    clearComments();
    if (sort != "") {
      this.sort = sort;
    }
    startLoading();
    if (sub.isEmpty ?? false || article.isEmpty ?? false) {
      return null;
    }

    String url = urlBuilder("$sub/comments/$article.json?sort=${this.sort}");
    var response = await buildRequestAndGet(url, accessToken: access);

    if (response.statusCode != 200) {
      print('error when calling comments');
      return null;
    }
    var data = json.decode(response.body);

    this.comments = CommentModel.parseListToCommentsTree(data);
    this.stopLoading();
  }

  Future<bool> postComment(
      String comment, String fullname, String access) async {
    String url = urlBuilder("api/comment");
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

  startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
