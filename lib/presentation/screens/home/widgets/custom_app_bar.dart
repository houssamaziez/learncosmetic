import 'package:flutter/material.dart';
import 'package:learncosmetic/core/constants/app_size.dart';

import '../../../../core/constants/app_colors.dart';

class AppbarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppbarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        'Learn Cosmetic',
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              const Icon(
                Icons.notifications_none,
                size: 28,
                color: AppColors.primary,
              ),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '0',
                  style: const TextStyle(
                    fontSize: AppSize.fontSizeS,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: AppSize.radiusM + 2,
              child: const CircleAvatar(
                radius: AppSize.radiusM,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.brown),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
