// import 'package:intl/intl.dart';
//
// String dateFormatted(DateTime date){
//   final DateFormat formatter = DateFormat('dd-MM-yyyy');
//   return formatter.format(date);
//
// }
extension FormateDate on DateTime{
  String get toFormattedDate=>'$day / $month / $year';
  String get toFormattedHour=>'$hour : $minute ';
  String get getDayName{
    List<String> weekDays=['MON','TUE','WED','THR','FRI','SAT','SUN'];
    //DateTime date=DateTime.now();
    return weekDays[weekday-1];
  }
}