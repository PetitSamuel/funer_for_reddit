import 'package:flutter/cupertino.dart';
import 'package:funer_for_reddit/providers/html_text_formatting_provider.dart';
import 'package:provider/provider.dart';

String htmlUnescapeConvert(BuildContext context, String s) {
  return Provider.of<HtmlTextFormattingProvider>(context).convert(s);
}
