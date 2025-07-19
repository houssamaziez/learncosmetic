class ApiConstants {
  static const String host = 'https://test.hatlifood.com';
  static const String apiPath = "/api";

  static const String baseUrl = '$host$apiPath';

  // Endpoints
  static const String login = '$baseUrl/login';
  static const String getme = '$baseUrl/me';
  static const String updateProfile = '$baseUrl/users/update/';

  static const String profile = '$baseUrl/profile';
  static const String register = '$baseUrl/register';
  static const String promotions = '$baseUrl/promotions';
  static const String categories = '$baseUrl/categories';
  static const String playlists = '$baseUrl/playlists';

  static const String episode = '$baseUrl/episode/';
  static const String episodePlaylist = '$baseUrl/episode/playlist/';
  static const String playlistsCategory = '$baseUrl/playlists/category/';
  static const String search = '$baseUrl/search';

  static const String book = '$baseUrl/books';
}
