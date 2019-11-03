import 'package:funer_for_reddit/models/post_models/link_flair_richtext_model.dart';

class PostModel {
  dynamic approvedAtUtc;
  String subreddit;
  String selftext;
  dynamic selftextHtml;
  dynamic secureMedia;
  bool saved;
  bool hideScore;
  int totalAwardsReceived;
  String subredditId;
  int score;
  int numComments;
  dynamic modReasonTitle;
  String whitelistStatus;
  List<Null> stewardReports;
  bool spoiler;
  String id;
  double createdUtc;
  dynamic bannedAtUtc;
  dynamic discussionType;
  dynamic edited;
  bool allowLiveComments;
  dynamic authorFlairBackgroundColor;
  dynamic approvedBy;
  //PostsFeedDataChildrenDataMediaEmbed mediaEmbed;
  String domain;
  bool noFollow;
  int ups;
  String authorFlairType;
  String permalink;
  List<String> contentCategories;
  int wls;
  dynamic authorFlairCssClass;
  List<Null> modReports;
  int gilded;
  dynamic removalReason;
  bool sendReplies;
  bool archived;
  dynamic authorFlairTextColor;
  bool canModPost;
  bool isSelf;
  String authorFullname;
  dynamic linkFlairCssClass;
  List<Null> userReports;
  bool isCrosspostable;
  bool clicked;
  dynamic authorFlairTemplateId;
  String url;
  String parentWhitelistStatus;
  bool stickied;
  bool quarantine;
  dynamic viewCount;
  List<LinkFlairRichtext> linkFlairRichtext;
  String linkFlairBackgroundColor;
  List<Null> authorFlairRichtext;
  bool over18;
  dynamic suggestedSort;
  bool canGild;
  bool isRobotIndexable;
  String postHint;
  bool locked;
  dynamic likes;
  String thumbnail;
  int downs;
  double created;
  String author;
  String linkFlairTextColor;
  //PostsFeedDataChildrenDataGildings gildings;
  dynamic reportReasons;
  bool isVideo;
  bool isOriginalContent;
  String subredditNamePrefixed;
  dynamic modReasonBy;
  String name;
  List<Null> awarders;
  bool mediaOnly;
  //PostsFeedDataChildrenDataPreview preview;
  dynamic numReports;
  bool pinned;
  bool hidden;
  bool authorPatreonFlair;
  dynamic modNote;
  dynamic media;
  String title;
  dynamic authorFlairText;
  int numCrossposts;
  int thumbnailWidth;
  // PostsFeedDataChildrenDataSecureMediaEmbed secureMediaEmbed;
  dynamic linkFlairText;
  String subredditType;
  bool isMeta;
  int subredditSubscribers;
  dynamic distinguished;
  int thumbnailHeight;
  String linkFlairType;
  //List<PostsFeedDatachildDataAllAwardings> allAwardings;
  bool visited;
  int pwls;
  dynamic category;
  dynamic bannedBy;
  bool contestMode;
  bool isRedditMediaDomain;
  PostModel crossParent;

  PostModel(
      {this.secureMedia,
      this.saved,
      this.hideScore,
      this.totalAwardsReceived,
      this.subredditId,
      this.score,
      this.numComments,
      this.modReasonTitle,
      this.whitelistStatus,
      this.stewardReports,
      this.spoiler,
      this.id,
      this.createdUtc,
      this.bannedAtUtc,
      this.discussionType,
      this.edited,
      this.allowLiveComments,
      this.authorFlairBackgroundColor,
      this.approvedBy,
//      this.mediaEmbed,
      this.domain,
      this.approvedAtUtc,
      this.noFollow,
      this.ups,
      this.authorFlairType,
      this.permalink,
      this.contentCategories,
      this.wls,
      this.authorFlairCssClass,
      this.modReports,
      this.gilded,
      this.removalReason,
      this.sendReplies,
      this.archived,
      this.authorFlairTextColor,
      this.canModPost,
      this.isSelf,
      this.authorFullname,
      this.linkFlairCssClass,
      this.selftext,
      this.selftextHtml,
      this.userReports,
      this.isCrosspostable,
      this.clicked,
      this.authorFlairTemplateId,
      this.url,
      this.parentWhitelistStatus,
      this.stickied,
      this.quarantine,
      this.viewCount,
      this.linkFlairRichtext,
      this.linkFlairBackgroundColor,
      this.authorFlairRichtext,
      this.over18,
      this.subreddit,
      this.suggestedSort,
      this.canGild,
      this.isRobotIndexable,
      this.postHint,
      this.locked,
      this.likes,
      this.thumbnail,
      this.downs,
      this.created,
      this.author,
      this.linkFlairTextColor,
      // this.gildings,
      this.reportReasons,
      this.isVideo,
      this.isOriginalContent,
      this.subredditNamePrefixed,
      this.modReasonBy,
      this.name,
      this.awarders,
      this.mediaOnly,
      // this.preview,
      this.numReports,
      this.pinned,
      this.hidden,
      this.authorPatreonFlair,
      this.modNote,
      this.media,
      this.title,
      this.authorFlairText,
      this.numCrossposts,
      this.thumbnailWidth,
      // this.secureMediaEmbed,
      this.linkFlairText,
      this.subredditType,
      this.isMeta,
      this.subredditSubscribers,
      this.distinguished,
      this.thumbnailHeight,
      this.linkFlairType,
      // this.allAwardings,
      this.visited,
      this.pwls,
      this.category,
      this.bannedBy,
      this.contestMode,
      this.isRedditMediaDomain,
      this.crossParent});

  static PostModel fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return new PostModel(
      secureMedia: json['secure_media'],
      saved: json['saved'],
      hideScore: json['hide_score'],
      totalAwardsReceived: json['total_awards_received'],
      subredditId: json['subreddit_id'],
      score: json['score'],
      numComments: json['num_comments'],
      modReasonTitle: json['mod_reason_title'],
      whitelistStatus: json['whitelist_status'],
      /* if (json['steward_reports'] != null) {
      stewardReports: new List<Null>();
    }
    */
      spoiler: json['spoiler'],
      id: json['id'],
      createdUtc: json['created_utc'],
      bannedAtUtc: json['banned_at_utc'],
      discussionType: json['discussion_type'],
      edited: json['edited'],
      allowLiveComments: json['allow_live_comments'],
      authorFlairBackgroundColor: json['author_flair_background_color'],
      approvedBy: json['approved_by'],
/*    mediaEmbed: json['media_embed'] != null
        ? new PostsFeedDataChildrenDataMediaEmbed.fromJson(json['media_embed'])
        : null;
  */
      domain: json['domain'],
      approvedAtUtc: json['approved_at_utc'],
      noFollow: json['no_follow'],
      ups: json['ups'],
      authorFlairType: json['author_flair_type'],
      permalink: json['permalink'],
      contentCategories: json['content_categories']?.cast<String>(),
      wls: json['wls'],
      authorFlairCssClass: json['author_flair_css_class'],
      /*  if (json['mod_reports'] != null) {
      modReports: new List<Null>();
    }
    */
      gilded: json['gilded'],
      removalReason: json['removal_reason'],
      sendReplies: json['send_replies'],
      archived: json['archived'],
      authorFlairTextColor: json['author_flair_text_color'],
      canModPost: json['can_mod_post'],
      isSelf: json['is_self'],
      authorFullname: json['author_fullname'],
      linkFlairCssClass: json['link_flair_css_class'],
      selftext: json['selftext'],
      selftextHtml: json['selftext_html'],
      /*  if (json['user_reports'] != null) {
      userReports: new List<Null>();
    }
    */
      isCrosspostable: json['is_crosspostable'],
      clicked: json['clicked'],
      authorFlairTemplateId: json['author_flair_template_id'],
      url: json['url'],
      parentWhitelistStatus: json['parent_whitelist_status'],
      stickied: json['stickied'],
      quarantine: json['quarantine'],
      viewCount: json['view_count'],
      linkFlairRichtext:
          LinkFlairRichtext.listFromJson(json['link_flair_richtext']),
      linkFlairBackgroundColor: json['link_flair_background_color'],
      /*  if (json['author_flair_richtext'] != null) {
      authorFlairRichtext: new List<Null>();
    }
    */
      over18: json['over_18'],
      subreddit: json['subreddit'],
      suggestedSort: json['suggested_sort'],
      canGild: json['can_gild'],
      isRobotIndexable: json['is_robot_indexable'],
      postHint: json['post_hint'],
      locked: json['locked'],
      likes: json['likes'],
      thumbnail: json['thumbnail'],
      downs: json['downs'],
      created: json['created'],
      author: json['author'],
      linkFlairTextColor: json['link_flair_text_color'],
      //   gildings: json['gildings'] != null
      //     ? new PostsFeedDataChildrenDataGildings.fromJson(json['gildings'])
      //   : null;
      reportReasons: json['report_reasons'],
      isVideo: json['is_video'],
      isOriginalContent: json['is_original_content'],
      subredditNamePrefixed: json['subreddit_name_prefixed'],
      modReasonBy: json['mod_reason_by'],
      name: json['name'],
      /*
    if (json['awarders'] != null) {
      awarders: new List<Null>();
    }
    */
      mediaOnly: json['media_only'],
      //   preview: json['preview'] != null
      //     ? new PostsFeedDataChildrenDataPreview.fromJson(json['preview'])
      //   : null;
      numReports: json['num_reports'],
      pinned: json['pinned'],
      hidden: json['hidden'],
      authorPatreonFlair: json['author_patreon_flair'],
      modNote: json['mod_note'],
      media: json['media'],
      title: json['title'],
      authorFlairText: json['author_flair_text'],
      numCrossposts: json['num_crossposts'],
      thumbnailWidth: json['thumbnail_width'],
      //  secureMediaEmbed: json['secure_media_embed'] != null
      //    ? new PostsFeedDataChildrenDataSecureMediaEmbed.fromJson(
      //      json['secure_media_embed'])
      //: null;
      linkFlairText: json['link_flair_text'],
      subredditType: json['subreddit_type'],
      isMeta: json['is_meta'],
      subredditSubscribers: json['subreddit_subscribers'],
      distinguished: json['distinguished'],
      thumbnailHeight: json['thumbnail_height'],
      linkFlairType: json['link_flair_type'],
      //  if (json['all_awardings'] != null) {
      //  allAwardings: new List<PostsFeedDatachildDataAllAwardings>();
      //(json['all_awardings'] as List).forEach((v) {
      //  allAwardings.add(new PostsFeedDatachildDataAllAwardings.fromJson(v));
      // });
      //}
      visited: json['visited'],
      pwls: json['pwls'],
      category: json['category'],
      bannedBy: json['banned_by'],
      contestMode: json['contest_mode'],
      isRedditMediaDomain: json['is_reddit_media_domain'],
      crossParent: json['crosspost_parent_list'] == null
          ? null
          : PostModel.fromJson(json['crosspost_parent_list'][0]),
    );
  }

  static List<PostModel> listFromJsonList(List<dynamic> values) {
    if (values == null || values.length == 0) {
      return [];
    }
    return values.map((v) {
      return PostModel.fromJson(v);
    }).toList();
  }
}
