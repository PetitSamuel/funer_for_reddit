import 'package:funer_for_reddit/models/post_model.dart';

SinglePostModel singlePostInstanceFromJson(Map<String, dynamic> json) {
  return new SinglePostModel(
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
    /*   if (json['link_flair_richtext'] != null) {
      linkFlairRichtext: new List<Null>();
    }
    */
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
  );
}
