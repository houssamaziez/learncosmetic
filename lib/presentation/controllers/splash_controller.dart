import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/presentation/controllers/login_controller.dart';

import '../../core/services/local_storage_service.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    Get.find<AuthController>().getMe();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);
    animationController.forward();

    Future.delayed(const Duration(seconds: 2), _navigateToNext);
  }

  void _navigateToNext() {
    LocalStorageService.getString('token') != null
        ? Get.offAllNamed(AppRoutes.home)
        : Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
