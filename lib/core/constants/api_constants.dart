class ApiConstants {
  static const String host = 'http://192.168.2.112:8000';
  static const String apiPath = "/api";

  static const String baseUrl = '$host$apiPath';

  // Endpoints
  static const String login = '$baseUrl/login';
  static const String profile = '$baseUrl/profile';
  static const String register = '$baseUrl/register';
  static const String promotions = '$baseUrl/promotions';
  static const String categories = '$baseUrl/categories';
}
