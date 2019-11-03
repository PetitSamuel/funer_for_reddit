class SubredditModel {
  final Object userFlairBackgroundColor;
  final Object submitTextHtml;
  final bool restrictPosting;
  final bool userIsBanned;
  final bool freeFormReports;
  final bool wikiEnabled;
  final bool userIsMuted;
  final Object userCanFlairInSr;
  final String displayName;
  final String headerImg;
  final String title;
  final Object iconSize;
  final String primaryColor;
  final Object activeUserCount;
  final String iconImg;
  final String displayNamePrefixed;
  final Object accountsActive;
  final bool publicTraffic;
  final int subscribers;
  final List<Object> userFlairRichtext;
  final int videostreamLinksCount;
  final String name;
  final bool quarantine;
  final bool hideAds;
  final bool emojisEnabled;
  final String advertiserCategory;
  final String publicDescription;
  final int commentScoreHideMins;
  final bool userHasFavorited;
  final Object userFlairTemplateId;
  final String communityIcon;
  final String bannerBackgroundImage;
  final bool originalContentTagEnabled;
  final String submitText;
  final String descriptionHtml;
  final bool spoilersEnabled;
  final Object headerTitle;
  final List<dynamic> headerSize;
  final String userFlairPosition;
  final bool allOriginalContent;
  final bool hasMenuWidget;
  final Object isEnrolledInNewModmail;
  final String keyColor;
  final bool canAssignUserFlair;
  final double created;
  final int wls;
  final bool showMediaPreview;
  final String submissionType;
  final bool userIsSubscriber;
  final bool disableContributorRequests;
  final bool allowVideogifs;
  final String userFlairType;
  final bool collapseDeletedComments;
  final Object emojisCustomSize;
  final String publicDescriptionHtml;
  final bool allowVideos;
  final bool isCrosspostableSubreddit;
  final String notificationLevel;
  final bool canAssignLinkFlair;
  final bool accountsActiveIsFuzzed;
  final Object submitTextLabel;
  final String linkFlairPosition;
  final Object userSrFlairEnabled;
  final bool userFlairEnabledInSr;
  final bool allowDiscovery;
  final bool userSrThemeEnabled;
  final bool linkFlairEnabled;
  final String subredditType;
  final Object suggestedCommentSort;
  final String bannerImg;
  final Object userFlairText;
  final String bannerBackgroundColor;
  final bool showMedia;
  final String id;
  final bool userIsModerator;
  final bool over18;
  final String description;
  final Object submitLinkLabel;
  final Object userFlairTextColor;
  final bool restrictCommenting;
  final Object userFlairCssClass;
  final bool allowImages;
  final String lang;
  final String whitelistStatus;
  final String url;
  final double createdUtc;
  final Object bannerSize;
  final String mobileBannerImage;
  final bool userIsContributor;

  SubredditModel(
      {this.userFlairBackgroundColor,
      this.submitTextHtml,
      this.restrictPosting,
      this.userIsBanned,
      this.freeFormReports,
      this.wikiEnabled,
      this.userIsMuted,
      this.userCanFlairInSr,
      this.displayName,
      this.headerImg,
      this.title,
      this.iconSize,
      this.primaryColor,
      this.activeUserCount,
      this.iconImg,
      this.displayNamePrefixed,
      this.accountsActive,
      this.publicTraffic,
      this.subscribers,
      this.userFlairRichtext,
      this.videostreamLinksCount,
      this.name,
      this.quarantine,
      this.hideAds,
      this.emojisEnabled,
      this.advertiserCategory,
      this.publicDescription,
      this.commentScoreHideMins,
      this.userHasFavorited,
      this.userFlairTemplateId,
      this.communityIcon,
      this.bannerBackgroundImage,
      this.originalContentTagEnabled,
      this.submitText,
      this.descriptionHtml,
      this.spoilersEnabled,
      this.headerTitle,
      this.headerSize,
      this.userFlairPosition,
      this.allOriginalContent,
      this.hasMenuWidget,
      this.isEnrolledInNewModmail,
      this.keyColor,
      this.canAssignUserFlair,
      this.created,
      this.wls,
      this.showMediaPreview,
      this.submissionType,
      this.userIsSubscriber,
      this.disableContributorRequests,
      this.allowVideogifs,
      this.userFlairType,
      this.collapseDeletedComments,
      this.emojisCustomSize,
      this.publicDescriptionHtml,
      this.allowVideos,
      this.isCrosspostableSubreddit,
      this.notificationLevel,
      this.canAssignLinkFlair,
      this.accountsActiveIsFuzzed,
      this.submitTextLabel,
      this.linkFlairPosition,
      this.userSrFlairEnabled,
      this.userFlairEnabledInSr,
      this.allowDiscovery,
      this.userSrThemeEnabled,
      this.linkFlairEnabled,
      this.subredditType,
      this.suggestedCommentSort,
      this.bannerImg,
      this.userFlairText,
      this.bannerBackgroundColor,
      this.showMedia,
      this.id,
      this.userIsModerator,
      this.over18,
      this.description,
      this.submitLinkLabel,
      this.userFlairTextColor,
      this.restrictCommenting,
      this.userFlairCssClass,
      this.allowImages,
      this.lang,
      this.whitelistStatus,
      this.url,
      this.createdUtc,
      this.bannerSize,
      this.mobileBannerImage,
      this.userIsContributor});

  static SubredditModel fromJson(Map<String, dynamic> json) {
    return new SubredditModel(
      userFlairBackgroundColor: json["user_flair_background_color"],
      submitTextHtml: json["submit_text_html"],
      restrictPosting: json["restrict_posting"],
      userIsBanned: json["user_is_banned"],
      freeFormReports: json["free_form_reports"],
      wikiEnabled: json["wiki_enabled"],
      userIsMuted: json["user_is_muted"],
      userCanFlairInSr: json["user_can_flair_in_sr"],
      displayName: json["display_name"],
      headerImg: json["header_img"],
      title: json["title"],
      iconSize: json["icon_size"],
      primaryColor: json["primary_color"],
      activeUserCount: json["active_user_count"],
      iconImg: json["icon_img"],
      displayNamePrefixed: json["display_name_prefixed"],
      accountsActive: json["accounts_active"],
      publicTraffic: json["public_traffic"],
      subscribers: json["subscribers"],
      userFlairRichtext: json["user_flair_richtext"],
      videostreamLinksCount: json["videostream_links_count"],
      name: json["name"],
      quarantine: json["quarantine"],
      hideAds: json["hide_ads"],
      emojisEnabled: json["emojis_enabled"],
      advertiserCategory: json["advertiser_category"],
      publicDescription: json["public_description"],
      commentScoreHideMins: json["comment_score_hideMins"],
      userHasFavorited: json["user_has_favorited"],
      userFlairTemplateId: json["user_flair_template_id"],
      communityIcon: json["community_icon"],
      bannerBackgroundImage: json["banner_background_image"],
      originalContentTagEnabled: json["original_content_tag_enabled"],
      submitText: json["submit_text"],
      descriptionHtml: json["description_html"],
      spoilersEnabled: json["spoilers_enabled"],
      headerTitle: json["header_title"],
      headerSize: json["header_size"] != null
          ? List<dynamic>.from(json["header_size"])
          : null,
      userFlairPosition: json["user_flair_position"],
      allOriginalContent: json["all_original_content"],
      hasMenuWidget: json["has_menu_widget"],
      isEnrolledInNewModmail: json["is_enrolled_in_new_modmail"],
      keyColor: json["key_color"],
      canAssignUserFlair: json["can_assign_user_flair"],
      created: json["created"],
      wls: json["wls"],
      showMediaPreview: json["show_media_preview"],
      submissionType: json["submission_type"],
      userIsSubscriber: json["user_is_subscriber"],
      disableContributorRequests: json["disable_contributor_requests"],
      allowVideogifs: json["allow_videogifs"],
      userFlairType: json["user_flair_type"],
      collapseDeletedComments: json["collapse_deleted_comments"],
      emojisCustomSize: json["emojis_custom_size"],
      publicDescriptionHtml: json["publicDescriptionHtml"],
      allowVideos: json["allowVideos"],
      isCrosspostableSubreddit: json["isCrosspostableSubreddit"],
      notificationLevel: json["notificationLevel"],
      canAssignLinkFlair: json["canAssignLinkFlair"],
      accountsActiveIsFuzzed: json["accountsActiveIsFuzzed"],
      submitTextLabel: json["submit_text_label"],
      linkFlairPosition: json["link_flair_position"],
      userSrFlairEnabled: json["user_sr_flair_enabled"],
      userFlairEnabledInSr: json["user_flair_enabled_in_sr"],
      allowDiscovery: json["allow_discovery"],
      userSrThemeEnabled: json["user_sr_theme_enabled"],
      linkFlairEnabled: json["link_flair_enabled"],
      subredditType: json["subreddit_type"],
      suggestedCommentSort: json["suggested_comment_sort"],
      bannerImg: json["banner_img"],
      userFlairText: json["user_flair_text"],
      bannerBackgroundColor: json["banner_background_color"],
      showMedia: json["show_media"],
      id: json["id"],
      userIsModerator: json["user_is_moderator"],
      over18: json["over18"],
      description: json["description"],
      submitLinkLabel: json["submit_link_label"],
      userFlairTextColor: json["user_flair_text_color"],
      restrictCommenting: json["restrict_commenting"],
      userFlairCssClass: json["user_flair_css_class"],
      allowImages: json["allow_images"],
      lang: json["lang"],
      whitelistStatus: json["whitelist_status"],
      url: json["url"],
      createdUtc: json["created_utc"],
      bannerSize: json["banner_size"],
      mobileBannerImage: json["mobile_banner_image"],
      userIsContributor: json["user_is_contributor"],
    );
  }
}
