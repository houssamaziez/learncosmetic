import 'package:get/get.dart';
import 'package:http/http.dart';
import '../../domain/repositories/user/user_repository_impl.dart'; // Ensure this import is present

import '../../domain/repositories/user/user_repository_impl.dart';
import '../../domain/usecases/ login_user.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Client());
    Get.lazyPut(() => UserRemoteDataSourceImpl(Get.find()));
    Get.lazyPut(() => UserRemoteDataSourceImpl(Get.find()));
    Get.lazyPut(() => LoginUser(Get.find()));
    Get.lazyPut(() => LoginController(loginUser: Get.find()));
  }
}
