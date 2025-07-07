class PromotionBanner {
  final int id;
  final String title;
  final String description;
  final String image;
  final DateTime startDate;
  final DateTime endDate;
  final int isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int playlistId; // Added playlist_id

  PromotionBanner({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.playlistId, // Added playlist_id to constructor
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'is_active': isActive == 1 ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'playlist_id': playlistId, // Added playlist_id to JSON
    };
  }

  factory PromotionBanner.fromJson(Map<String, dynamic> json) {
    return PromotionBanner(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      isActive: int.tryParse(json['is_active'].toString()) ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      playlistId:
          int.tryParse(json['playlist_id'].toString()) ??
          0, // Added playlist_id from JSON
    );
  }
}
