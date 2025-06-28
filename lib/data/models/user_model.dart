class UserModel {
  final String id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? phone;
  final String? address;
  final String? imageUser;
  final String? role;
  final bool? active;
  final bool? isPayment;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.address,
    this.imageUser,
    this.role,
    this.active,
    this.isPayment,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      phone: json['phone'],
      address: json['address'],
      imageUser: json['imageuser'],
      role: json['role'],
      active: json['active'],
      isPayment: json['ispayment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'phone': phone,
      'address': address,
      'imageuser': imageUser,
      'role': role,
      'active': active,
      'ispayment': isPayment,
    };
  }
}
