class Commenter {
  final int id;
  final int userId;
  final String userName;
  final String content;
  final DateTime createdAt;

  Commenter({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    required this.createdAt,
  });

  factory Commenter.fromJson(Map<String, dynamic> json) {
    return Commenter(
      id: json['id'],
      userId: json['user_id'],
      userName: json['user_name'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user_name': userName,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
