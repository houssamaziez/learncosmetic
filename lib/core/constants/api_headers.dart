import 'package:learncosmetic/core/services/local_storage_service.dart';

class ApiHeaders {
  /// Header without auth
  static Map<String, String> json = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Header with bearer token
  static Map<String, String> withToken() => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${LocalStorageService.getString('token')}',
  };
}
