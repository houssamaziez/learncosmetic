import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void onInit() {
    super.onInit();

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
    // TODO: Add your logic here (check login, etc)
    // Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
