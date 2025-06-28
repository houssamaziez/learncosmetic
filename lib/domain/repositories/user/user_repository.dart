import '../../../data/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> login(String email, String password);

  Future<UserModel> getProfile(String token);
}
