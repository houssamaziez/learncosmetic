import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/presentation/controllers/login_controller.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/local_storage_service.dart';

class HiUser extends StatelessWidget {
  const HiUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8, left: 16.0, top: 8, right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "! ${Get.find<AuthController>().user!.name ?? ""}، أهلاً بكِ ",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "استكشفي أحدث الدورات في عالم التجميل",
              style: TextStyle(
                color: const Color.fromARGB(255, 65, 16, 20),
                fontSize: 16,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
