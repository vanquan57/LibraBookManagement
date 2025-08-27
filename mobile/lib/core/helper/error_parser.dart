import 'package:dio/dio.dart';

String getErrorMessage(DioException e) {
  try {
    if (e.error is String) {
      return e.error as String;
    }

    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    if (data is Map<String, dynamic> && data['errors'] != null) {
      final errors = data['errors'];

      if (statusCode == 422 && errors is Map<String, dynamic>) {
        final firstError = errors.values.first;

        if (firstError is List && firstError.isNotEmpty) {
          return firstError.first.toString();
        }
      }

      if (errors is Map<String, dynamic> && errors['error_message'] is String) {
        return errors['error_message'];
      }
    }

    return 'Đã có lỗi xảy ra';
  } catch (_) {
    return 'Đã có lỗi xảy ra';
  }
}
