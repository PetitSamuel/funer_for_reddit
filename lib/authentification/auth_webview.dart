import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/*
  The webview widget used to load the reddit oauth page.
*/
class AuthWebview extends StatelessWidget {
  final String url;

  AuthWebview({@required this.url});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebviewScaffold(
        url: url,
        appBar: AppBar(
          title: Text('Logging into reddit.'),
        ),
        scrollBar: true,
        withJavascript: true,
      ),
    );
  }
}
