import 'package:timeago/timeago.dart' as timeago;

String changeToTimeAgo(String dateTime) {
  final formatedTimeAgo = timeago.format(DateTime.parse(dateTime));
  return formatedTimeAgo;
}
