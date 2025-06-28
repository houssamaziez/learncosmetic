import '../../data/models/user_model.dart';
import '../repositories/user/user_repository_impl.dart';

class LoginUser {
  final UserRemoteDataSourceImpl repository;

  LoginUser(this.repository);

  Future<UserModel?> call(String email, String password) {
    return repository.login(email, password);
  }
}
