class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  /// تحويل البيانات من JSON إلى كائن (Object)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  /// تحويل الكائن إلى JSON لإرساله إلى الـ API
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}
