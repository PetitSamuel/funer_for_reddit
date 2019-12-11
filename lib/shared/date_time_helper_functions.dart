import 'package:timeago/timeago.dart' as timeago;

/*
 * Helper functions to display time information into widgets.
*/
String getTimeAgoAsString(double utc) {
  var postedDate =
      new DateTime.fromMillisecondsSinceEpoch(utc.round() * 1000, isUtc: false);
  var now = new DateTime.now();
  var diff = now.difference(postedDate);
  return timeago.format(now.subtract(diff), locale: 'en_short');
}
