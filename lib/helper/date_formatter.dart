import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String toTime(DateTime date) {
    return DateFormat.jm().format(date);
  }

  static String toMonth(DateTime date) {
    return DateFormat.yMMMM().format(date);
  }

  static String toYearMonthDay(DateTime date) {
    return DateFormat.yMMMEd().format(date);
  }

  static String toMonthDay(DateTime date) {
    return DateFormat.MMMEd().format(date);
  }

  static String toDMY(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  static String toWholeDate(DateTime date) {
    return "${toYearMonthDay(date)} | ${toTime(date)}";
  }
   static int daysBetween(DateTime from, DateTime to) {
     from = DateTime(from.year, from.month, from.day);
     to = DateTime(to.year, to.month, to.day);
   return (to.difference(from).inHours / 24).round();
  }
   DateTime dt1 = DateTime.parse("2021-12-23 11:47:00");
DateTime dt2 = DateTime.parse("2018-09-12 10:57:00");

static  int differenceInHours (DateTime from, DateTime to){
     to = DateTime(to.year, to.month, to.day);
     from = DateTime(from.year, from.month, from.day);
    return to.difference(from).inHours;

}
   //the birthday's date
  //  final birthday = DateTime(1967, 10, 12);
  //  final date2 = DateTime.now();
  //  static difference = daysBetween(birthday, date2);
}
