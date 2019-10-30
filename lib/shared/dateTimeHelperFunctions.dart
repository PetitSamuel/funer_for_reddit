import 'package:timeago/timeago.dart' as timeago;

String getTimeAgoAsString(double utc) {
  var postedDate =
      new DateTime.fromMillisecondsSinceEpoch(utc.round() * 1000, isUtc: false);
  var now = new DateTime.now();
  var diff = now.difference(postedDate);
  print(diff.inDays);
  print(diff.inMinutes);
  return timeago.format(now.subtract(diff));
  //return now.toString();
}
