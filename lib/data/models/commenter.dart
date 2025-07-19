import 'package:learncosmetic/core/constants/api_constants.dart';

class Commenter {
  final int id;
  final int userId;
  final String userName;
  final String content;
  final DateTime createdAt;
  String? userImage;

  Commenter({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    required this.createdAt,
    required this.userImage,
  });

  factory Commenter.fromJson(Map<String, dynamic> json) {
    return Commenter(
      id: json['id'],
      userId: int.parse(json['user_id'].toString()),
      userName: json['user_name'],
      content: json['content'],
      userImage:
          json['imageuser'] != null
              ? "${ApiConstants.host}/${json['imageuser']}"
              : "",
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user_name': userName,
      'content': content,
      'imageuser': userImage,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
