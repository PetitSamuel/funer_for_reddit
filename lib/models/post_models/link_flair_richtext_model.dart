class LinkFlairRichtext {
  String e;
  String t;

  LinkFlairRichtext({this.e, this.t});

  static List<LinkFlairRichtext> listFromJson(List<dynamic> values) {
    if (values == null || values.length == 0) {
      return new List();
    }
    return values.map((v) {
      return new LinkFlairRichtext(
        e: v['e'],
        t: v['t'],
      );
    }).toList();
  }
}
