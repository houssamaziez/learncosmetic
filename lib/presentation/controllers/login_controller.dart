import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/data/models/user_model.dart';
import 'package:learncosmetic/domain/usecases/%20login_user.dart';
import '../../../core/constants/error_notifier.dart';
import '../../domain/usecases/register_user.dart';
import '../../routes/app_routes.dart';

class AuthController extends GetxController {
  final LoginUser loginUser;
  final RegisterUser registerUser;

  AuthController({required this.loginUser, required this.registerUser});

  // Fields
  final nameController = TextEditingController();
  final emailController = TextEditingController(text: 'houssamaziez@gmail.com');
  final passwordController = TextEditingController(text: 'secret123');
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  bool isLoadingUpdate = false;

  final loginError = ''.obs;
  final isLogin = true.obs;

  UserModel? user;

  void setLogin(bool value) => isLogin.value = value;

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      loginError.value = 'Please fill in all fields';
      return;
    }

    isLoading.value = true;
    loginError.value = '';

    try {
      user = await loginUser(email, password);
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      ErrorNotifier.show(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getMe() async {
    isLoading.value = true;
    loginError.value = '';

    try {
      user = await loginUser.getMe();
      // Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      ErrorNotifier.show(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      loginError.value = 'Please fill in all fields';
      return;
    }

    if (password != confirmPassword) {
      loginError.value = 'Passwords do not match';
      return;
    }

    isLoading.value = true;
    loginError.value = '';

    try {
      final user = await registerUser(
        name,
        email,
        password,
        confirmPassword,
      ); // Replace with registerUser if separate
      // await LocalStorageService.setString('token', user.token ?? '');
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      ErrorNotifier.show(e.toString());
    } finally {
      isLoading.value = false;
    }
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
    isLoadingUpdate = true;
    update();

    try {
      await loginUser
          .updateProfile(
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            phone: phone,
            address: address,
            imageuser: imageuser,
          )
          .then((value) => getMe());
      update();
    } catch (e) {
      ErrorNotifier.show(e.toString());
    } finally {
      isLoadingUpdate = false;
      update();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
