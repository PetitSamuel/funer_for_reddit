import 'package:html_unescape/html_unescape.dart';

class HtmlTextFormattingProvider {
  HtmlUnescape htmlUnescape;

  HtmlTextFormattingProvider() {
    this.htmlUnescape = new HtmlUnescape();
  }

  String convert(String s) {
    return this.htmlUnescape.convert(s);
  }
}
