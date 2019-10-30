class SubredditInformationModel {
  String userFlairPosition;
  String publicDescription;
  String keyColor;
  int activeUserCount;
  int accountsActive;
  bool userIsBanned;
  dynamic submitTextLabel;
  String userFlairTextColor;
  bool emojisEnabled;
  bool userIsMuted;
  bool disableContributorRequests;
  String publicDescriptionHtml;
  dynamic isCrosspostableSubreddit;
  bool userIsSubscriber;
  String whitelistStatus;
  List<int> iconSize;
  bool userFlairEnabledInSr;
  String id;
  bool showMedia;
  double createdUtc;
  int commentScoreHideMins;
  dynamic isEnrolledInNewModmail;
  //List<SubredditInformationDataUserFlairRichtext> userFlairRichtext;
  dynamic headerTitle;
  bool restrictCommenting;
  int subscribers;
  double created;
  bool restrictPosting;
  String communityIcon;
  String displayName;
  String primaryColor;
  String linkFlairPosition;
  bool linkFlairEnabled;
  bool userIsContributor;
  bool canAssignUserFlair;
  String submitLinkLabel;
  String bannerImg;
  String userFlairCssClass;
  String name;
  bool allowVideogifs;
  String userFlairType;
  String notificationLevel;
  String descriptionHtml;
  bool userSrFlairEnabled;
  int wls;
  dynamic suggestedCommentSort;
  String submitText;
  bool userHasFavorited;
  bool accountsActiveIsFuzzed;
  bool allowImages;
  bool publicTraffic;
  String description;
  String title;
  String userFlairText;
  String bannerBackgroundColor;
  String userFlairTemplateId;
  String displayNamePrefixed;
  String submissionType;
  bool spoilersEnabled;
  bool showMediaPreview;
  bool userSrThemeEnabled;
  bool freeFormReports;
  String lang;
  bool userIsModerator;
  dynamic userFlairBackgroundColor;
  bool allowDiscovery;
  String bannerBackgroundImage;
  String subredditType;
  bool over18;
  dynamic bannerSize;
  dynamic headerSize;
  bool collapseDeletedComments;
  String advertiserCategory;
  bool hasMenuWidget;
  bool originalContentTagEnabled;
  bool allOriginalContent;
  String url;
  String mobileBannerImage;
  bool userCanFlairInSr;
  bool allowVideos;
  dynamic headerImg;
  String iconImg;
  String submitTextHtml;
  bool wikiEnabled;
  bool quarantine;
  bool hideAds;
  dynamic emojisCustomSize;
  bool canAssignLinkFlair;

  SubredditInformationModel(
      {this.userFlairPosition,
      this.publicDescription,
      this.keyColor,
      this.activeUserCount,
      this.accountsActive,
      this.userIsBanned,
      this.submitTextLabel,
      this.userFlairTextColor,
      this.emojisEnabled,
      this.userIsMuted,
      this.disableContributorRequests,
      this.publicDescriptionHtml,
      this.isCrosspostableSubreddit,
      this.userIsSubscriber,
      this.whitelistStatus,
      this.iconSize,
      this.userFlairEnabledInSr,
      this.id,
      this.showMedia,
      this.createdUtc,
      this.commentScoreHideMins,
      this.isEnrolledInNewModmail,
      //  this.userFlairRichtext,
      this.headerTitle,
      this.restrictCommenting,
      this.subscribers,
      this.created,
      this.restrictPosting,
      this.communityIcon,
      this.displayName,
      this.primaryColor,
      this.linkFlairPosition,
      this.linkFlairEnabled,
      this.userIsContributor,
      this.canAssignUserFlair,
      this.submitLinkLabel,
      this.bannerImg,
      this.userFlairCssClass,
      this.name,
      this.allowVideogifs,
      this.userFlairType,
      this.notificationLevel,
      this.descriptionHtml,
      this.userSrFlairEnabled,
      this.wls,
      this.suggestedCommentSort,
      this.submitText,
      this.userHasFavorited,
      this.accountsActiveIsFuzzed,
      this.allowImages,
      this.publicTraffic,
      this.description,
      this.title,
      this.userFlairText,
      this.bannerBackgroundColor,
      this.userFlairTemplateId,
      this.displayNamePrefixed,
      this.submissionType,
      this.spoilersEnabled,
      this.showMediaPreview,
      this.userSrThemeEnabled,
      this.freeFormReports,
      this.lang,
      this.userIsModerator,
      this.userFlairBackgroundColor,
      this.allowDiscovery,
      this.bannerBackgroundImage,
      this.subredditType,
      this.over18,
      this.bannerSize,
      this.headerSize,
      this.collapseDeletedComments,
      this.advertiserCategory,
      this.hasMenuWidget,
      this.originalContentTagEnabled,
      this.allOriginalContent,
      this.url,
      this.mobileBannerImage,
      this.userCanFlairInSr,
      this.allowVideos,
      this.headerImg,
      this.iconImg,
      this.submitTextHtml,
      this.wikiEnabled,
      this.quarantine,
      this.hideAds,
      this.emojisCustomSize,
      this.canAssignLinkFlair});

  static SubredditInformationModel fromJson(Map<String, dynamic> json) {
    return new SubredditInformationModel(
      userFlairPosition: json['user_flair_position'],
      publicDescription: json['public_description'],
      keyColor: json['key_color'],
      activeUserCount: json['active_user_count'],
      accountsActive: json['accounts_active'],
      userIsBanned: json['user_is_banned'],
      submitTextLabel: json['submit_text_label'],
      userFlairTextColor: json['user_flair_text_color'],
      emojisEnabled: json['emojis_enabled'],
      userIsMuted: json['user_is_muted'],
      disableContributorRequests: json['disable_contributor_requests'],
      publicDescriptionHtml: json['public_description_html'],
      isCrosspostableSubreddit: json['is_crosspostable_subreddit'],
      userIsSubscriber: json['user_is_subscriber'],
      whitelistStatus: json['whitelist_status'],
      iconSize: json['icon_size']?.cast<int>(),
      userFlairEnabledInSr: json['user_flair_enabled_in_sr'],
      id: json['id'],
      showMedia: json['show_media'],
      createdUtc: json['created_utc'],
      commentScoreHideMins: json['comment_score_hide_mins'],
      isEnrolledInNewModmail: json['is_enrolled_in_new_modmail'],
      /*
    if (json['user_flair_richtext'] != null) {
      userFlairRichtext: new List<SubredditInformationDataUserFlairRichtext>();
      (json['user_flair_richtext'] as List).forEach((v) {
        userFlairRichtext
            .add(new SubredditInformationDataUserFlairRichtext.fromJson(v));
      });
    }
    */
      headerTitle: json['header_title'],
      restrictCommenting: json['restrict_commenting'],
      subscribers: json['subscribers'],
      created: json['created'],
      restrictPosting: json['restrict_posting'],
      communityIcon: json['community_icon'],
      displayName: json['display_name'],
      primaryColor: json['primary_color'],
      linkFlairPosition: json['link_flair_position'],
      linkFlairEnabled: json['link_flair_enabled'],
      userIsContributor: json['user_is_contributor'],
      canAssignUserFlair: json['can_assign_user_flair'],
      submitLinkLabel: json['submit_link_label'],
      bannerImg: json['banner_img'],
      userFlairCssClass: json['user_flair_css_class'],
      name: json['name'],
      allowVideogifs: json['allow_videogifs'],
      userFlairType: json['user_flair_type'],
      notificationLevel: json['notification_level'],
      descriptionHtml: json['description_html'],
      userSrFlairEnabled: json['user_sr_flair_enabled'],
      wls: json['wls'],
      suggestedCommentSort: json['suggested_comment_sort'],
      submitText: json['submit_text'],
      userHasFavorited: json['user_has_favorited'],
      accountsActiveIsFuzzed: json['accounts_active_is_fuzzed'],
      allowImages: json['allow_images'],
      publicTraffic: json['public_traffic'],
      description: json['description'],
      title: json['title'],
      userFlairText: json['user_flair_text'],
      bannerBackgroundColor: json['banner_background_color'],
      userFlairTemplateId: json['user_flair_template_id'],
      displayNamePrefixed: json['display_name_prefixed'],
      submissionType: json['submission_type'],
      spoilersEnabled: json['spoilers_enabled'],
      showMediaPreview: json['show_media_preview'],
      userSrThemeEnabled: json['user_sr_theme_enabled'],
      freeFormReports: json['free_form_reports'],
      lang: json['lang'],
      userIsModerator: json['user_is_moderator'],
      userFlairBackgroundColor: json['user_flair_background_color'],
      allowDiscovery: json['allow_discovery'],
      bannerBackgroundImage: json['banner_background_image'],
      subredditType: json['subreddit_type'],
      over18: json['over18'],
      bannerSize: json['banner_size'],
      headerSize: json['header_size'],
      collapseDeletedComments: json['collapse_deleted_comments'],
      advertiserCategory: json['advertiser_category'],
      hasMenuWidget: json['has_menu_widget'],
      originalContentTagEnabled: json['original_content_tag_enabled'],
      allOriginalContent: json['all_original_content'],
      url: json['url'],
      mobileBannerImage: json['mobile_banner_image'],
      userCanFlairInSr: json['user_can_flair_in_sr'],
      allowVideos: json['allow_videos'],
      headerImg: json['header_img'],
      iconImg: json['icon_img'],
      submitTextHtml: json['submit_text_html'],
      wikiEnabled: json['wiki_enabled'],
      quarantine: json['quarantine'],
      hideAds: json['hide_ads'],
      emojisCustomSize: json['emojis_custom_size'],
      canAssignLinkFlair: json['can_assign_link_flair'],
    );
  }
}
