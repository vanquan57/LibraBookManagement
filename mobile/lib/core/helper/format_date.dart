import 'package:intl/intl.dart';

/// Format a DateTime to a string in the format 'dd/MM/yyyy'
/// 
/// @param DateTime date
/// 
/// @return String
String formatDay(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(DateTime.parse(date.toString()));
}
