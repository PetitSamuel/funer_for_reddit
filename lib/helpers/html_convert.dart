import 'package:html_unescape/html_unescape.dart';

String htmlUnescapeConvert(String s) {
  return HtmlUnescape().convert(s);
}
