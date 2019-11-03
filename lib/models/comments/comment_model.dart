import 'package:funer_for_reddit/shared/constants.dart';

class CommentModel {
  int totalAwardsReceived;
  double approvedAtUtc;
  int ups;
  var awarders;
  var modReasonBy;
  var bannedBy;
  String authorFlairType;
  var removalReason;
  String linkId;
  var authorFlairTemplateId;
  var likes;
  List<CommentModel> replies;
  var userReports;
  bool saved;
  String id;
  double bannedAtUtc;
  String modReasonTitle;
  int gilded;
  bool archived;
  bool noFollow;
  String author;
  bool canModPost;
  bool sendReplies;
  String parentId;
  int score;
  String authorFullname;
  var reportReasons;
  var allAwardings;
  String subredditId;
  String body;
  var edited;
  var authorFlairCssClass;
  var stewardReports;
  bool isSubmitter;
  int downs;
  List<dynamic> authorFlairRichText;
  bool authorPatreonFlair;
  String bodyHtml;
  var gildings;
  var collapsedReason;
  var associatedAward;
  bool stickied;
  String subredditType;
  String subreddit;
  bool canGild;
  String authorFlairTextColor;
  bool scoreHidden;
  String permalink;
  int numRepports;
  bool locked;
  String name;
  double created;
  String authorFlairText;
  bool collapsed;
  double createdUtc;
  String subredditNamePrefixed;
  int controversiality;
  int depth;
  String authorFlairBackgroundColor;
  var modReports;
  var modNote;
  var distinguished;

  CommentModel(
      {this.totalAwardsReceived,
      this.approvedAtUtc,
      this.ups,
      this.awarders,
      this.modReasonBy,
      this.bannedBy,
      this.authorFlairType,
      this.removalReason,
      this.linkId,
      this.authorFlairTemplateId,
      this.likes,
      this.replies,
      this.userReports,
      this.saved,
      this.id,
      this.bannedAtUtc,
      this.modReasonTitle,
      this.gilded,
      this.archived,
      this.noFollow,
      this.author,
      this.canModPost,
      this.sendReplies,
      this.parentId,
      this.score,
      this.authorFullname,
      this.reportReasons,
      this.allAwardings,
      this.subredditId,
      this.body,
      this.edited,
      this.authorFlairCssClass,
      this.stewardReports,
      this.isSubmitter,
      this.downs,
      this.authorFlairRichText,
      this.authorPatreonFlair,
      this.bodyHtml,
      this.gildings,
      this.collapsedReason,
      this.associatedAward,
      this.stickied,
      this.subredditType,
      this.subreddit,
      this.canGild,
      this.authorFlairTextColor,
      this.scoreHidden,
      this.permalink,
      this.numRepports,
      this.locked,
      this.name,
      this.created,
      this.authorFlairText,
      this.collapsed,
      this.createdUtc,
      this.subredditNamePrefixed,
      this.controversiality,
      this.depth,
      this.authorFlairBackgroundColor,
      this.modReports,
      this.modNote,
      this.distinguished});

  static CommentModel fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return new CommentModel(
      allAwardings: json["all_awardings"],
      approvedAtUtc: json["approved_at_utc"],
      archived: json["archived"],
      associatedAward: json["associated_award"],
      author: json["author"],
      authorFlairBackgroundColor: json["author_flair_background_color"],
      authorFlairCssClass: json["author_flair_css_class"],
      authorFlairRichText: json["author_flair_richtext"],
      authorFlairTemplateId: json["author_flair_template_id"],
      authorFlairText: json["author_flair_text"],
      authorFlairTextColor: json["author_flair_text_color"],
      authorFlairType: json["author_flair_type"],
      authorFullname: json["author_fullname"],
      authorPatreonFlair: json["author_patreon_flair"],
      awarders: json["awarders"],
      bannedAtUtc: json["banned_at_utc"],
      bannedBy: json["banned_by"],
      body: json["body"],
      bodyHtml: json["body_html"],
      canGild: json["can_gild"],
      canModPost: json["can_mod_post"],
      collapsed: json["collapsed"],
      collapsedReason: ["collapsed_reason"],
      controversiality: json["controversiality"],
      created: json["created"],
      createdUtc: json["created_utc"],
      depth: json["depth"],
      distinguished: json["distinguished"],
      downs: json["downs"],
      edited: json["edited"],
      gilded: json["gilded"],
      gildings: json["gildings"],
      id: json["id"],
      isSubmitter: json["is_submitter"],
      likes: json["likes"],
      linkId: json["link_id"],
      locked: json["locked"],
      modNote: json["mod_note"],
      modReasonBy: json["mod_reason_by"],
      modReasonTitle: json["mod_reason_title"],
      modReports: json["mod_reports"],
      name: json["name"],
      noFollow: json["no_follow"],
      numRepports: json["num_reports"],
      parentId: json["parent_id"],
      permalink: json["permalink"],
      removalReason: json["removal_reason"],
      replies: mapToComments(json["replies"] == "" ? null : json["replies"]),
      reportReasons: json["report_reasons"],
      saved: json["saved"],
      score: json["score"],
      scoreHidden: json["score_hidden"],
      sendReplies: json["send_replies"],
      stewardReports: json["steward_reports"],
      stickied: json["stickied"],
      subreddit: json["subreddit"],
      subredditId: json["subreddit_id"],
      subredditNamePrefixed: json["subreddit_name_prefixed"],
      subredditType: json["subreddit_type"],
      totalAwardsReceived: json["total_awards_received"],
      ups: json["ups"],
      userReports: json["user_reports"],
    );
  }

  static List<CommentModel> parseListToCommentsTree(List<dynamic> response) {
    if (response == null) {
      return null;
    }
    List<CommentModel> comments = new List();
    for (final item in response) {
      List<CommentModel> newComs = mapToComments(item);
      if (newComs == null) continue;
      comments.addAll(newComs);
    }
    return comments;
  }

  static List<CommentModel> mapToComments(Map<String, dynamic> item) {
    if (item == null ||
        item["data"] == null ||
        item["data"]["children"] == null) {
      return null;
    }
    List<dynamic> children = item["data"]["children"];

    if (children == null || children.length == 0) return null;
    List<CommentModel> comments = new List();
    for (final child in children) {
      if (child == null) {
        continue;
      }
      // check if kind is comment
      if (child["kind"] != COMMENT_TYPE) {
        continue;
      }
      Map<String, dynamic> commentData = child["data"];
      CommentModel comment = fromJson(commentData);
      if (comment != null) comments.add(comment);
    }

    return comments;
  }
}
