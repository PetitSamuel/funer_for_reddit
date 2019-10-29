import 'package:funer_for_reddit/models/subreddit_model.dart';
import 'package:funer_for_reddit/models/user_information_model.dart';

UserInformation parseFromMeResponse(Map<String, dynamic> response) {
  return new UserInformation(
      iconColor: response['subreddit']['icon_color'] ?? "",
      iconImg: response['subreddit']['icon_img'] ?? "",
      displayNamePrefixed: response['subreddit']['display_name_prefixed'] ?? "",
      commentKarma: (response['comment_karma']).toString() ?? "",
      linkKarma: response['link_karma'].toString() ?? "",
      subredditsList: new List());
}

Subreddit subredditFromSubscriptions(Map<String, dynamic> response) {
  String iconUrl = response['icon_img'] ?? "";
  if (iconUrl.isEmpty) {
    iconUrl = response['community_icon'] ?? "";
  }
  if (iconUrl.isEmpty) {
    iconUrl = response['header_img'] ?? "";
  }
  return new Subreddit(
      displayName: response['display_name'],
      headerImg: response['header_img'],
      displayNamePrefixed: response['display_name_prefixed'],
      subscribers: response['subscribers'].toString(),
      communityIcon: iconUrl,
      userIsSubscriber: response['user_is_subscriber'].toString(),
      url: response['url']);
}
