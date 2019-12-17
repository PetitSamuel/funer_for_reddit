import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/models_export.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:funer_for_reddit/widgets/feed_body.dart';
import 'package:provider/provider.dart';

class SubredditPage extends StatefulWidget {
  SubredditPage({Key key, this.subreddit}) : super(key: key);

  final String subreddit;

  @override
  _SubredditPageState createState() => _SubredditPageState();
}

class _SubredditPageState extends State<SubredditPage> {
  @override
  Widget build(BuildContext context) {
    SubredditModel sub =
        Provider.of<UserProvider>(context).getSub(widget.subreddit);
    print(sub);
    String bgImg = "";
    String iconUrl = "";
    if (sub != null) {
      bgImg = sub.bannerImg ?? "";
      if (bgImg.isEmpty) bgImg = sub.bannerBackgroundImage ?? "";
      iconUrl = sub.iconImg ?? "";
      if (iconUrl.isEmpty) iconUrl = sub.communityIcon ?? "";
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Funer for Reddit."),
        ),
        body: Container(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              if (sub != null)
                Center(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: iconUrl.isEmpty
                            ? Icon(Icons.error)
                            : CachedNetworkImage(
                                imageUrl: iconUrl,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                        title: Text(sub.displayNamePrefixed),
                        trailing: IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () => _showDialog(sub.publicDescription),
                        ),
                      ),
                    ],
                  ),
                ),
              FeedBody(),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Description"),
            content: Text(text),
          );
        });
  }
}
