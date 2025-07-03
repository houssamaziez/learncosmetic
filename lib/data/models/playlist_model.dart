class Playlist {
  final int id;
  final String title;
  final String description;
  final String? imageUrl;
  final CategoryPlaylist category;
  final int coursesCount; // Add this line

  Playlist({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.category,
    required this.coursesCount, // Add this line
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image'],
      category: CategoryPlaylist.fromJson(json['category']),
      coursesCount: json['courses_count'], // Add this line
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'category': category.toJson(),
      'courses_count': coursesCount, // Add this line
    };
  }
}

class CategoryPlaylist {
  final int id;
  final String name;

  CategoryPlaylist({required this.id, required this.name});

  factory CategoryPlaylist.fromJson(Map<String, dynamic> json) {
    return CategoryPlaylist(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
