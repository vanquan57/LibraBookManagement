import 'package:mobile/core/config/constant.dart';

class Validators {
  static String? required(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập $fieldName';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  static String? vkuEmail(String? value) {
    final baseError = email(value);
    if (baseError != null) return baseError;

    if (!value!.endsWith(AppConstants.EMAIL_VKU)) {
      return 'Email không đúng định dạng';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }

    if (value.length < 8) {
      return 'Mật khẩu phải có ít nhất 8 ký tự';
    }

    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      return 'Mật khẩu phải có ít nhất một chữ cái viết hoa';
    }

    if (!RegExp(r'^(?=.*[!@#$%^&*])').hasMatch(value)) {
      return 'Mật khẩu phải có ít nhất một ký tự đặc biệt (!@#\$%^&*)';
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng xác nhận mật khẩu';
    }

    if (value != password) {
      return 'Mật khẩu không khớp';
    }

    return null;
  }

  static String? studentCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mã sinh viên';
    }

    if (!RegExp(r'^\d{2}IT\d{3}$').hasMatch(value)) {
      return 'Mã sinh viên không hợp lệ';
    }

    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập họ và tên';
    }

    if (value.length > 100) {
      return 'Họ và tên không được vượt quá 100 ký tự';
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }

    if (!RegExp(r'^[0-9]{10,11}$').hasMatch(value)) {
      return 'Vui lòng nhập số điện thoại hợp lệ (10-11 số)';
    }

    return null;
  }

  static String? address(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập địa chỉ';
    }

    if (value.length < 5) {
      return 'Địa chỉ phải có ít nhất 5 ký tự';
    }

    if (value.length > 200) {
      return 'Địa chỉ không được vượt quá 200 ký tự';
    }

    return null;
  }

  static String? dropdown(int? value, String fieldName) {
    if (value == null) {
      return 'Vui lòng chọn $fieldName';
    }
    return null;
  }

  static String? feedbackContent(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nội dung đánh giá không được để trống';
    }

    if (value.length > 255) {
      return 'Nội dung đánh giá không được quá 255 ký tự';
    }

    return null;
  }

  static String? feedbackStar(int? value) {
    if (value == null || value == 0) {
      return 'Vui lòng chọn số sao đánh giá';
    }
    return null;
  }
}
