import 'package:learncosmetic/data/models/episode_model.dart';
import 'course_model.dart';
import 'playlist_model.dart';
import 'category_model.dart';

class SearchResultModel {
  final bool status;
  final String keyword;
  final List<CategoryModel> categories;
  final List<Playlist> playlists;
  final List<Episode> courses;

  SearchResultModel({
    required this.status,
    required this.keyword,
    required this.categories,
    required this.playlists,
    required this.courses,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      status: json['status'] ?? false,
      keyword: json['keyword'] ?? '',
      categories:
          (json['categories'] != null)
              ? List<CategoryModel>.from(
                (json['categories'] as List).map(
                  (e) => CategoryModel.fromJson(e),
                ),
              )
              : [],
      playlists:
          (json['playlists'] != null)
              ? List<Playlist>.from(
                (json['playlists'] as List).map((e) => Playlist.fromJson(e)),
              )
              : [],
      courses:
          (json['courses'] != null)
              ? List<Episode>.from(
                (json['courses'] as List).map((e) => Episode.fromJson(e)),
              )
              : [],
    );
  }
}
