import 'package:flutter/cupertino.dart';
import 'package:funer_for_reddit/models/models_export.dart';
import 'package:html_unescape/html_unescape_small.dart';

Widget postHeaderContent(PostModel post) {
  var imgsrc = PostModel.getPreviewImageSource(post);

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      // image preview display
      if (imgsrc != null)
        Flexible(
          child: Container(
            margin: EdgeInsets.only(left: 12, top: 8),
            child: Image.network(
              HtmlUnescape().convert(imgsrc.url),
            ),
          ),
          flex: 4,
        ),
      // post title
      Flexible(
        child: Container(
          margin: EdgeInsets.only(left: 12, top: 4),
          child: Text(
            post.title + '\n',
            style: TextStyle(fontSize: 20),
          ),
        ),
        flex: 12,
      ),
    ],
  );
}
