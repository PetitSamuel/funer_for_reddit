class SinglePostModel {
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
  List<Null> linkFlairRichtext;
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
  // PostsFeedDataChildrenDataPreview preview;
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

  SinglePostModel(
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
      this.isRedditMediaDomain});
}
