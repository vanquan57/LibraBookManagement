import 'package:intl/intl.dart';

/// Format a DateTime to a string in the format 'dd/MM/yyyy'
/// 
/// @param DateTime date
/// 
/// @return String
String formatDay(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}
