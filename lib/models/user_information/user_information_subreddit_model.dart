class UserInformationSubredditModel {
  String publicDescription;
  String keyColor;
  bool over18;
  bool userIsBanned;
  String description;
  String title;
  String submitTextLabel;
  bool isDefaultBanner;
  bool userIsMuted;
  bool isDefaultIcon;
  bool disableContributorRequests;
  String displayNamePrefixed;
  bool userIsSubscriber;
  List<int> iconSize;
  bool freeFormReports;
  bool showMedia;
  bool defaultSet;
  bool userIsModerator;
  dynamic bannerSize;
  String subredditType;
  bool restrictCommenting;
  int coins;
  int subscribers;
  dynamic headerSize;
  bool restrictPosting;
  String communityIcon;
  String displayName;
  String primaryColor;
  String url;
  bool userIsContributor;
  String linkFlairPosition;
  bool linkFlairEnabled;
  String submitLinkLabel;
  dynamic headerImg;
  String iconColor;
  String iconImg;
  String bannerImg;
  String name;

  UserInformationSubredditModel(
      {this.publicDescription,
      this.keyColor,
      this.over18,
      this.userIsBanned,
      this.description,
      this.title,
      this.submitTextLabel,
      this.isDefaultBanner,
      this.userIsMuted,
      this.isDefaultIcon,
      this.disableContributorRequests,
      this.displayNamePrefixed,
      this.userIsSubscriber,
      this.iconSize,
      this.freeFormReports,
      this.showMedia,
      this.defaultSet,
      this.userIsModerator,
      this.bannerSize,
      this.subredditType,
      this.restrictCommenting,
      this.coins,
      this.subscribers,
      this.headerSize,
      this.restrictPosting,
      this.communityIcon,
      this.displayName,
      this.primaryColor,
      this.url,
      this.userIsContributor,
      this.linkFlairPosition,
      this.linkFlairEnabled,
      this.submitLinkLabel,
      this.headerImg,
      this.iconColor,
      this.iconImg,
      this.bannerImg,
      this.name});

  static UserInformationSubredditModel userSubredditInformationfromJson(
      Map<String, dynamic> json) {
    if (json == null) return new UserInformationSubredditModel();
    return new UserInformationSubredditModel(
      publicDescription: json['public_description'],
      keyColor: json['key_color'],
      over18: json['over_18'],
      userIsBanned: json['user_is_banned'],
      description: json['description'],
      title: json['title'],
      submitTextLabel: json['submit_text_label'],
      isDefaultBanner: json['is_default_banner'],
      userIsMuted: json['user_is_muted'],
      isDefaultIcon: json['is_default_icon'],
      disableContributorRequests: json['disable_contributor_requests'],
      displayNamePrefixed: json['display_name_prefixed'],
      userIsSubscriber: json['user_is_subscriber'],
      iconSize: json['icon_size']?.cast<int>(),
      freeFormReports: json['free_form_reports'],
      showMedia: json['show_media'],
      defaultSet: json['default_set'],
      userIsModerator: json['user_is_moderator'],
      bannerSize: json['banner_size'],
      subredditType: json['subreddit_type'],
      restrictCommenting: json['restrict_commenting'],
      coins: json['coins'],
      subscribers: json['subscribers'],
      headerSize: json['header_size'],
      restrictPosting: json['restrict_posting'],
      communityIcon: json['community_icon'],
      displayName: json['display_name'],
      primaryColor: json['primary_color'],
      url: json['url'],
      userIsContributor: json['user_is_contributor'],
      linkFlairPosition: json['link_flair_position'],
      linkFlairEnabled: json['link_flair_enabled'],
      submitLinkLabel: json['submit_link_label'],
      headerImg: json['header_img'],
      iconColor: json['icon_color'],
      iconImg: json['icon_img'],
      bannerImg: json['banner_img'],
      name: json['name'],
    );
  }
}
