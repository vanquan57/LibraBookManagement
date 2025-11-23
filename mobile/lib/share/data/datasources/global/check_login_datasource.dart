import 'package:dio/dio.dart';
import 'package:mobile/core/helper/error_parser.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckLoginDatasource {
  final Dio _dio;

  CheckLoginDatasource(this._dio);

  /// Check if user is logged in
  ///
  /// @return boolean
  Future<bool> checkIsLogin() async {
    try {
      final response = await _dio.get('/profile');

      if (response.data['success'] == true) {
        return true;
      }

      return false;
    } on DioException catch (e) {
      log.e('Login failed: ${getErrorMessage(e)}');

      return false;
    } catch (e) {
      log.e('Login failed w: $e');

      return false;
    }
  }
}
