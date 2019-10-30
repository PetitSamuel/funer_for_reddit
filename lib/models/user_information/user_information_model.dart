import 'package:funer_for_reddit/models/user_information/user_information_features_model.dart';
import 'package:funer_for_reddit/models/user_information/user_information_subreddit_model.dart';

class UserInformationModel {
  bool hasStripeSubscription;
  bool canCreateSubreddit;
  bool over18;
  int prefClickgadget;
  int commentKarma;
  UserInformationSubredditModel subreddit;
  UserInformationFeaturesModel features;
  bool prefShowTrending;
  String id;
  bool hasVisitedNewProfile;
  double createdUtc;
  int numFriends;
  int coins;
  bool inRedesignBeta;
  bool hasModMail;
  bool hideFromRobots;
  bool hasSubscribedToPremium;
  double created;
  bool hasSubscribed;
  bool hasAndroidSubscription;
  bool seenPremiumAdblockModal;
  bool prefShowSnoovatar;
  bool forcePasswordReset;
  String name;
  bool isGold;
  bool isMod;
  bool inBeta;
  bool hasVerifiedEmail;
  String prefGeopopular;
  bool isSuspended;
  dynamic newModmailExists;
  bool isSponsor;
  bool seenRedesignModal;
  bool hasExternalAccount;
  dynamic suspensionExpirationUtc;
  bool hasGoldSubscription;
  bool seenLayoutSwitch;
  bool prefNightmode;
  int linkKarma;
  bool hasMail;
  String oauthClientId;
  bool prefAutoplay;
  int goldCreddits;
  bool verified;
  bool hasPaypalSubscription;
  bool prefTopKarmaSubreddits;
  bool prefShowTwitter;
  bool isEmployee;
  bool prefVideoAutoplay;
  bool prefNoProfanity;
  String iconImg;
  int inboxCount;
  bool hasIosSubscription;
  dynamic goldExpiration;
  bool seenSubredditChatFtux;

  UserInformationModel(
      {this.hasStripeSubscription,
      this.canCreateSubreddit,
      this.over18,
      this.prefClickgadget,
      this.commentKarma,
      this.subreddit,
      this.features,
      this.prefShowTrending,
      this.id,
      this.hasVisitedNewProfile,
      this.createdUtc,
      this.numFriends,
      this.coins,
      this.inRedesignBeta,
      this.hasModMail,
      this.hideFromRobots,
      this.hasSubscribedToPremium,
      this.created,
      this.hasSubscribed,
      this.hasAndroidSubscription,
      this.seenPremiumAdblockModal,
      this.prefShowSnoovatar,
      this.forcePasswordReset,
      this.name,
      this.isGold,
      this.isMod,
      this.inBeta,
      this.hasVerifiedEmail,
      this.prefGeopopular,
      this.isSuspended,
      this.newModmailExists,
      this.isSponsor,
      this.seenRedesignModal,
      this.hasExternalAccount,
      this.suspensionExpirationUtc,
      this.hasGoldSubscription,
      this.seenLayoutSwitch,
      this.prefNightmode,
      this.linkKarma,
      this.hasMail,
      this.oauthClientId,
      this.prefAutoplay,
      this.goldCreddits,
      this.verified,
      this.hasPaypalSubscription,
      this.prefTopKarmaSubreddits,
      this.prefShowTwitter,
      this.isEmployee,
      this.prefVideoAutoplay,
      this.prefNoProfanity,
      this.iconImg,
      this.inboxCount,
      this.hasIosSubscription,
      this.goldExpiration,
      this.seenSubredditChatFtux});

  static UserInformationModel fromJson(Map<String, dynamic> json) {
    if (json == null) return new UserInformationModel();
    return new UserInformationModel(
      hasStripeSubscription: json['has_stripe_subscription'],
      canCreateSubreddit: json['can_create_subreddit'],
      over18: json['over_18'],
      prefClickgadget: json['pref_clickgadget'],
      commentKarma: json['comment_karma'],
      subreddit: UserInformationSubredditModel.userSubredditInformationfromJson(
          json['subreddit']),
      features: UserInformationFeaturesModel.userInformationFeaturesFromJson(
          json['features']),
      prefShowTrending: json['pref_show_trending'],
      id: json['id'],
      hasVisitedNewProfile: json['has_visited_new_profile'],
      createdUtc: json['created_utc'],
      numFriends: json['num_friends'],
      coins: json['coins'],
      inRedesignBeta: json['in_redesign_beta'],
      hasModMail: json['has_mod_mail'],
      hideFromRobots: json['hide_from_robots'],
      hasSubscribedToPremium: json['has_subscribed_to_premium'],
      created: json['created'],
      hasSubscribed: json['has_subscribed'],
      hasAndroidSubscription: json['has_android_subscription'],
      seenPremiumAdblockModal: json['seen_premium_adblock_modal'],
      prefShowSnoovatar: json['pref_show_snoovatar'],
      forcePasswordReset: json['force_password_reset'],
      name: json['name'],
      isGold: json['is_gold'],
      isMod: json['is_mod'],
      inBeta: json['in_beta'],
      hasVerifiedEmail: json['has_verified_email'],
      prefGeopopular: json['pref_geopopular'],
      isSuspended: json['is_suspended'],
      newModmailExists: json['new_modmail_exists'],
      isSponsor: json['is_sponsor'],
      seenRedesignModal: json['seen_redesign_modal'],
      hasExternalAccount: json['has_external_account'],
      suspensionExpirationUtc: json['suspension_expiration_utc'],
      hasGoldSubscription: json['has_gold_subscription'],
      seenLayoutSwitch: json['seen_layout_switch'],
      prefNightmode: json['pref_nightmode'],
      linkKarma: json['link_karma'],
      hasMail: json['has_mail'],
      oauthClientId: json['oauth_client_id'],
      prefAutoplay: json['pref_autoplay'],
      goldCreddits: json['gold_creddits'],
      verified: json['verified'],
      hasPaypalSubscription: json['has_paypal_subscription'],
      prefTopKarmaSubreddits: json['pref_top_karma_subreddits'],
      prefShowTwitter: json['pref_show_twitter'],
      isEmployee: json['is_employee'],
      prefVideoAutoplay: json['pref_video_autoplay'],
      prefNoProfanity: json['pref_no_profanity'],
      iconImg: json['icon_img'],
      inboxCount: json['inbox_count'],
      hasIosSubscription: json['has_ios_subscription'],
      goldExpiration: json['gold_expiration'],
      seenSubredditChatFtux: json['seen_subreddit_chat_ftux'],
    );
  }
}
