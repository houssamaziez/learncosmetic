class ApiHeaders {
  /// Header without auth
  static Map<String, String> json = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Header with bearer token
  static Map<String, String> withToken(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
