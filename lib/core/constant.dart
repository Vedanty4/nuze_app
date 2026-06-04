import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static String get NewsApiKey => dotenv.env['NewsApi'] ?? '';
  static String get GNewsApi => dotenv.env['GNewsApi'] ?? '';
}
