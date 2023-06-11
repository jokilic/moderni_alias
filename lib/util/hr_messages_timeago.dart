import 'package:timeago/timeago.dart';

///
/// CROATIAN TIMEAGO MESSAGES
///
class HrMessagesTimeago implements LookupMessages {
  @override
  String prefixAgo() => 'prije';
  @override
  String prefixFromNow() => 'od';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => 'od sad';
  @override
  String lessThanOneMinute(int seconds) => 'trenutka';
  @override
  String aboutAMinute(int minutes) => 'oko minute';
  @override
  String minutes(int minutes) => '$minutes minuta';
  @override
  String aboutAnHour(int minutes) => 'jedan sat';
  @override
  String hours(int hours) => '$hours sati';
  @override
  String aDay(int hours) => 'dan';
  @override
  String days(int days) => '$days dana';
  @override
  String aboutAMonth(int days) => 'mjesec dana';
  @override
  String months(int months) => '$months mjeseci';
  @override
  String aboutAYear(int year) => 'godine dana';
  @override
  String years(int years) => '$years godina';
  @override
  String wordSeparator() => ' ';
}
