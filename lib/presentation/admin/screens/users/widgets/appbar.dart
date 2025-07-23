import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../routes/app_routes.dart';

class AppbarUsers extends StatelessWidget implements PreferredSizeWidget {
  const AppbarUsers({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('قائمة المستخدمين'),
      centerTitle: true,
      backgroundColor: AppColors.primary.withOpacity(0.05),
      actions: [
        IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.addUser);
          },
          icon: Icon(Icons.add),
          color: Colors.black,
        ),
      ],
    );
  }
}
