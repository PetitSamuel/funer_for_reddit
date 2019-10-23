import 'package:funer_for_reddit/models/User.dart';

UserInformation parseFromMeResponse(Map<String, dynamic> response) {
  return new UserInformation(
      icon_color: response['subreddit']['icon_color'] ?? "",
      icon_img: response['subreddit']['icon_img'] ?? "",
      display_name_prefixed:
          response['subreddit']['display_name_prefixed'] ?? "",
      comment_karma: (response['comment_karma']).toString() ?? "",
      link_karma: response['link_karma'].toString() ?? "",
      subredditsList: new List());
}
