import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get baseUrl => dotenv.env['API_BASE_URL']!;
  static String get googleClientId => dotenv.env['GOOGLE_CLIENT_ID']!;
}
