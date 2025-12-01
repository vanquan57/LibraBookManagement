import 'package:intl/intl.dart';

/// Format a DateTime to a string in the format 'yyyy-MM-dd' for API submission
/// 
/// @param DateTime date
/// 
/// @return String
String formatDay(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(DateTime.parse(date.toString()));
}

/// Format a DateTime to a string in the format 'dd/MM/yyyy' for display
/// 
/// @param DateTime date
/// 
/// @return String
String formatDateDisplay(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

/// Format a date string (from API) to display format 'dd/MM/yyyy'
/// 
/// @param String dateString
/// 
/// @return String
String formatDateStringDisplay(String dateString) {
  try {
    final date = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(date);
  } catch (e) {
    return dateString;
  }
}
