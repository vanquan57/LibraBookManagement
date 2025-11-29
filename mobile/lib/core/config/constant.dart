import 'package:mobile/core/config/env.dart';

class AppConstants {
  static const String EMAIL_VKU = 'vku.udn.vn';
  static final String BASE_URL_IMAGE = Env.baseUrl.replaceAll('api/v1/user', '') + 'storage/images/';
  static const int TRUE = 1;
  static const int FALSE = 0;
  static const int LIMIT_BOOK = 6;
  static const int LIMIT_CATEGORY = 6;
  static const int LIMIT_INFINITY = 9007199254740991;
  static const String DEFAULT_ORDER = 'desc';
}
