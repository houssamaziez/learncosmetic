import 'dart:io';

import '../../../data/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> login(String email, String password);
  Future<UserModel?> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  );

  Future<UserModel> getProfile();

  Future<void> updateProfile({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? phone,
    String? address,
    File? imageuser,
  });
}
