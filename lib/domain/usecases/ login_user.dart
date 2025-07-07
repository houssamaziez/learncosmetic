import 'dart:io';

import '../../data/models/user_model.dart';
import '../repositories/user/user_repository_impl.dart';

class LoginUser {
  final UserRemoteDataSourceImpl repository;

  LoginUser(this.repository);

  Future<UserModel?> call(String email, String password) {
    return repository.login(email, password);
  }

  Future<UserModel?> getMe() {
    return repository.getProfile();
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? phone,
    String? address,
    File? imageuser,
  }) async {
    return repository.updateProfile(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
      address: address,
      imageuser: imageuser,
    );
  }
}
