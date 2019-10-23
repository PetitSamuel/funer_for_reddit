import './Subreddit.dart';

class UserInformation {
  String icon_color;
  String icon_img;
  String display_name_prefixed;
  String comment_karma;
  String link_karma;
  List<Subreddit> subredditsList;

  UserInformation({
    this.icon_color,
    this.icon_img,
    this.display_name_prefixed,
    this.comment_karma,
    this.link_karma,
    this.subredditsList,
  });
}
