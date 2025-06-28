import 'package:flutter/material.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final int notificationCount;

  const CustomAppBar({
    super.key,
    this.onNotificationTap,
    this.onProfileTap,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Notifications with badge
          GestureDetector(
            onTap: onNotificationTap,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                const Icon(
                  Icons.notifications_none,
                  size: 28,
                  color: AppColors.primary,
                ),
                if (notificationCount > 0)
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      notificationCount.toString(),
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),

          // App name
          const Text(
            'Learn Cosmetic',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Profile avatar
          GestureDetector(
            onTap: onProfileTap,
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 18,
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.brown),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
