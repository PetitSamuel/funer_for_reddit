import 'package:funer_for_reddit/models/subreddit_model.dart';

class UserInformation {
  String iconColor;
  String iconImg;
  String displayNamePrefixed;
  String commentKarma;
  String linkKarma;
  List<Subreddit> subredditsList;

  UserInformation({
    this.iconColor,
    this.iconImg,
    this.displayNamePrefixed,
    this.commentKarma,
    this.linkKarma,
    this.subredditsList,
  });
}
