import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:learncosmetic/core/constants/app_size.dart';
import 'package:learncosmetic/routes/app_routes.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../controllers/login_controller.dart';
import '../../profile/profile_screen.dart';

class AppbarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppbarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.toNamed(AppRoutes.changeLanguageScreen);
        },
        icon: const Icon(Icons.language, color: AppColors.primary),
      ),
      backgroundColor: AppColors.primary.withOpacity(0.1),
      title: const Text(
        'Learn Cosmetic',
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,

      // leading: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: GestureDetector(
      //     child: Stack(
      //       alignment: Alignment.topRight,
      //       children: [
      //         const Icon(
      //           Icons.notifications_none,
      //           size: 28,
      //           color: AppColors.primary,
      //         ),
      //         Container(
      //           padding: const EdgeInsets.all(3),
      //           decoration: const BoxDecoration(
      //             color: Colors.red,
      //             shape: BoxShape.circle,
      //           ),
      //           child: Text(
      //             '0',
      //             style: const TextStyle(
      //               fontSize: AppSize.fontSizeS,
      //               color: Colors.white,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      actions: [
        GetBuilder<AuthController>(
          builder: (controller) {
            if (controller.user != null && controller.user!.imageUser != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => Get.to(UserProfileScreen()),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage:
                        controller.user!.imageUser != null
                            ? NetworkImage(controller.user!.imageUser!)
                            : null,
                    child:
                        controller.user!.imageUser == null
                            ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            )
                            : null,
                  ),
                ),
              );
            }
            return GestureDetector(
              child: CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: AppSize.radiusM + 2,
                child: const CircleAvatar(
                  radius: AppSize.radiusM,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.brown),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
