import 'package:learncosmetic/core/constants/api_constants.dart';
import '../../core/constants/api_constants.dart';
import 'playlist_model.dart'; // أو الملف الذي يحتوي على PlaylistEpisode

class Episode {
  final int id;
  final int playlistId;
  final String title;
  final String description;
  final String videoPath;
  final String imagePath;
  final String videoDuration;
  final bool isWatched;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PlaylistEpisode? playlist;

  Episode({
    required this.id,
    required this.playlistId,
    required this.title,
    required this.description,
    required this.videoPath,
    required this.imagePath,
    required this.videoDuration,
    required this.isWatched,
    required this.createdAt,
    required this.updatedAt,
    required this.playlist,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      playlistId: json['playlist_id'],
      title: json['title'],
      description: json['description'],
      videoPath: ApiConstants.host + "/" + json['video_path'],
      imagePath: ApiConstants.host + "/" + json['image_path'],
      videoDuration: json['video_duration'].toString(),
      isWatched: json['is_watched'] == 1,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      playlist:
          json['playlist'] != null
              ? PlaylistEpisode.fromJson(json['playlist'])
              : null,
    );
  }
}

class PlaylistEpisode {
  final int id;
  final int categoryId;
  final String title;
  final String image;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  PlaylistEpisode({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.image,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlaylistEpisode.fromJson(Map<String, dynamic> json) {
    return PlaylistEpisode(
      id: json['id'],
      categoryId: json['category_id'],
      title: json['title'],
      image: json['image'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
