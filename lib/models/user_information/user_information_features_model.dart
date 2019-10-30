class UserInformationFeaturesModel {
  bool chatUserSettings;
  bool modAwards;
  bool stewardUi;
  bool chatGroupRollout;
  bool mwebXpromoInterstitialCommentsAndroid;
  bool twitterEmbed;
  bool showAmpLink;
  bool mwebXpromoInterstitialCommentsIos;
  bool doNotTrack;
  bool customFeeds;
  bool spezModal;
  //UserInformationFeaturesMwebXpromoRevampV3 mwebXpromoRevampV3;
  bool awarderNames;
  bool chatRollout;
  bool mwebXpromoModalListingClickDailyDismissibleAndroid;
  // UserInformationFeaturesMwebNsfwXpromo mwebNsfwXpromo;
  // UserInformationFeaturesDefaultSrsHoldout defaultSrsHoldout;
  bool layersCreation;
  bool premiumSubscriptionsTable;
  bool mwebXpromoModalListingClickDailyDismissibleIos;
  bool dualWriteUserPrefs;
  bool modlogCopyrightRemoval;
  bool richtextPreviews;
  bool chatSubreddit;
  bool communityAwards;
  bool isEmailPermissionRequired;
  bool readFromPrefService;
  bool chatReddarReports;

  UserInformationFeaturesModel(
      {this.chatUserSettings,
      this.modAwards,
      this.stewardUi,
      this.chatGroupRollout,
      this.mwebXpromoInterstitialCommentsAndroid,
      this.twitterEmbed,
      this.showAmpLink,
      this.mwebXpromoInterstitialCommentsIos,
      this.doNotTrack,
      this.customFeeds,
      this.spezModal,
      //  this.mwebXpromoRevampV3,
      this.awarderNames,
      this.chatRollout,
      this.mwebXpromoModalListingClickDailyDismissibleAndroid,
      // this.mwebNsfwXpromo,
      // this.defaultSrsHoldout,
      this.layersCreation,
      this.premiumSubscriptionsTable,
      this.mwebXpromoModalListingClickDailyDismissibleIos,
      this.dualWriteUserPrefs,
      this.modlogCopyrightRemoval,
      this.richtextPreviews,
      this.chatSubreddit,
      this.communityAwards,
      this.isEmailPermissionRequired,
      this.readFromPrefService,
      this.chatReddarReports});

  static UserInformationFeaturesModel userInformationFeaturesFromJson(
      Map<String, dynamic> json) {
    if (json == null) return new UserInformationFeaturesModel();
    return new UserInformationFeaturesModel(
      chatUserSettings: json['chat_user_settings'],
      modAwards: json['mod_awards'],
      stewardUi: json['steward_ui'],
      chatGroupRollout: json['chat_group_rollout'],
      mwebXpromoInterstitialCommentsAndroid:
          json['mweb_xpromo_interstitial_comments_android'],
      twitterEmbed: json['twitter_embed'],
      showAmpLink: json['show_amp_link'],
      mwebXpromoInterstitialCommentsIos:
          json['mweb_xpromo_interstitial_comments_ios'],
      doNotTrack: json['do_not_track'],
      customFeeds: json['custom_feeds'],
      spezModal: json['spez_modal'],
      /*
    mwebXpromoRevampV3: json['mweb_xpromo_revamp_v3'] != null
        ? new UserInformationFeaturesMwebXpromoRevampV3.fromJson(
            json['mweb_xpromo_revamp_v3'])
        : null;
        */
      awarderNames: json['awarder_names'],
      chatRollout: json['chat_rollout'],
      mwebXpromoModalListingClickDailyDismissibleAndroid:
          json['mweb_xpromo_modal_listing_click_daily_dismissible_android'],
      /*
    mwebNsfwXpromo: json['mweb_nsfw_xpromo'] != null
        ? new UserInformationFeaturesMwebNsfwXpromo.fromJson(
            json['mweb_nsfw_xpromo'])
        : null;
        
    defaultSrsHoldout: json['default_srs_holdout'] != null
        ? new UserInformationFeaturesDefaultSrsHoldout.fromJson(
            json['default_srs_holdout'])
        : null;
        */
      layersCreation: json['layers_creation'],
      premiumSubscriptionsTable: json['premium_subscriptions_table'],
      mwebXpromoModalListingClickDailyDismissibleIos:
          json['mweb_xpromo_modal_listing_click_daily_dismissible_ios'],
      dualWriteUserPrefs: json['dual_write_user_prefs'],
      modlogCopyrightRemoval: json['modlog_copyright_removal'],
      richtextPreviews: json['richtext_previews'],
      chatSubreddit: json['chat_subreddit'],
      communityAwards: json['community_awards'],
      isEmailPermissionRequired: json['is_email_permission_required'],
      readFromPrefService: json['read_from_pref_service'],
      chatReddarReports: json['chat_reddar_reports'],
    );
  }
}
