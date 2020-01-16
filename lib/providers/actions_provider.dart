import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/shared/constants.dart';
import 'package:funer_for_reddit/shared/requests_shared.dart';

/*
  Provider for executing actions such as upvote, posting & such.
*/
class ActionsProvider with ChangeNotifier {
  bool isVoteLoading = false;

  Future<int> upvote(String post, bool likes, String access) async {
    this.isVoteLoading = true;
    notifyListeners();

    int dir = UPVOTE_DIR;
    if (likes == true) dir = RESET_VOTE_DIR;

    bool status = await sendVote(post, dir, access);
    if (status) return dir;
    return null;
  }

  Future<int> downvote(String post, bool likes, String access) async {
    this.isVoteLoading = true;
    notifyListeners();

    int dir = DOWNVOTE_DIR;
    if (likes == false) dir = RESET_VOTE_DIR;

    bool status = await sendVote(post, dir, access);
    if (status) return dir;
    return null;
  }

  Future<bool> sendVote(String post, int dir, String access) async {
    String url = urlBuilder("api/vote");
    String body = "id=$post&dir=$dir&api_type=json";

    var response = await buildRequestAndPost(url,
        body: body, headers: buildHeadersFromToken(access));

    if (response.statusCode != 200) {
      print("error when voting post thing");
      // todo : handle error message
      return false;
    }

    this.isVoteLoading = false;
    notifyListeners();
    return true;
  }
}
