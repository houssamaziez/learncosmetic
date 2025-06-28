import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/data/models/user_model.dart';

import '../../../core/services/local_storage_service.dart';
import '../../core/constants/error_notifier.dart';
import '../../domain/usecases/ login_user.dart';

class LoginController extends GetxController {
  final LoginUser loginUser;

  LoginController({required this.loginUser});

  final emailController = TextEditingController(text: 'houssam@mail.com');
  final passwordController = TextEditingController(text: '123456');

  var isLoading = false.obs;
  var loginError = ''.obs;

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      loginError.value = 'Please fill in all fields';
      return;
    }

    isLoading.value = true;
    loginError.value = '';

    try {
      UserModel? user = await loginUser(email, password);
      // await LocalStorageService.setString('token', 'example_token');
      Get.offAllNamed('/home'); // Navigate to home screen
    } catch (e) {
      ErrorNotifier.show((e).toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
