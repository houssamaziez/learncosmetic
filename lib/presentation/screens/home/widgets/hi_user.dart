import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/presentation/controllers/login_controller.dart';

import '../../../../core/constants/app_colors.dart';

class HiUser extends StatelessWidget {
  const HiUser({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = Get.find<AuthController>().user?.name ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'welcome_user'.trParams({'name': userName}),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'explore_latest_beauty_courses'.tr,
              style: const TextStyle(color: Color(0xFF411014), fontSize: 16),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
