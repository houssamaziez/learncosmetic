import '../../data/models/user_model.dart';
import '../repositories/user/user_repository_impl.dart';

class RegisterUser {
  final UserRemoteDataSourceImpl repository;

  RegisterUser(this.repository);

  Future<UserModel?> call(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) {
    return repository.register(name, email, password, confirmPassword);
  }
}
