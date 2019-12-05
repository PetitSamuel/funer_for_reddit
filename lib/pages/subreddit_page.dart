import 'package:flutter/material.dart';
import 'package:funer_for_reddit/widgets/feed_body.dart';

class SubredditPage extends StatefulWidget {
  SubredditPage({Key key, this.subreddit}) : super(key: key);

  final String subreddit;

  @override
  _SubredditPageState createState() => _SubredditPageState();
}

class _SubredditPageState extends State<SubredditPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Funer for Reddit."),
        ),
        body: Container(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Center(child: Text(widget.subreddit)),
              FeedBody(),
            ],
          ),
        ),
      ),
    );
  }
}
