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
  final int commentsCount;
  int likesCount;

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
    required this.commentsCount,
    required this.likesCount,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      playlistId: int.parse(json['playlist_id'].toString()) ?? 0,
      title: json['title'],
      description: json['description'],
      videoPath: json['video_path'],
      imagePath: json['image_path'],
      videoDuration: json['video_duration'].toString(),
      isWatched: json['is_watched'] == 1,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      playlist:
          json['playlist'] != null
              ? PlaylistEpisode.fromJson(json['playlist'])
              : null,
      commentsCount: int.parse(json['comments_count'].toString()) ?? 0,
      likesCount: int.parse(json['likes_count'].toString()) ?? 0,
    );
  }

  Episode copyWith({
    int? id,
    int? playlistId,
    String? title,
    String? description,
    String? videoPath,
    String? imagePath,
    String? videoDuration,
    bool? isWatched,
    DateTime? createdAt,
    DateTime? updatedAt,
    PlaylistEpisode? playlist,
    int? commentsCount,
    int? likesCount,
  }) {
    return Episode(
      id: id ?? this.id,
      playlistId: playlistId ?? this.playlistId,
      title: title ?? this.title,
      description: description ?? this.description,
      videoPath: videoPath ?? this.videoPath,
      imagePath: imagePath ?? this.imagePath,
      videoDuration: videoDuration ?? this.videoDuration,
      isWatched: isWatched ?? this.isWatched,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      playlist: playlist ?? this.playlist,
      commentsCount: commentsCount ?? this.commentsCount,
      likesCount: likesCount ?? this.likesCount,
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
      id: json['id'] ?? 0,
      categoryId: int.parse(json['category_id'].toString()) ?? 0,
      title: json['title'],
      image: json['image'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
