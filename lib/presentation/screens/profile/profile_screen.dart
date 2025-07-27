import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_size.dart';
import '../../controllers/login_controller.dart';
import 'package:learncosmetic/presentation/screens/auth/auth_screen.dart';
import 'package:learncosmetic/presentation/screens/profile/update_user_profile_screen.dart';
import 'package:learncosmetic/presentation/widgets/spinkit.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key}) : super(key: key);

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        final user = controller.user;

        if (user == null) {
          return Scaffold(body: Center(child: spinkit));
        }

        final expiryDate =
            user.expirydate != null
                ? DateTime.tryParse(user.expirydate!)
                : null;

        final isExpired =
            expiryDate != null && expiryDate.isBefore(DateTime.now());

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "profile_page".tr,
              style: TextStyle(color: AppColors.primary),
            ),
            centerTitle: true,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            actions: [
              IconButton(
                onPressed: () => Get.to(UpdateUserProfileScreen(user: user)),
                icon: const Icon(Icons.edit, color: AppColors.primary),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSize.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage:
                      user.imageUser != null
                          ? NetworkImage(user.imageUser!)
                          : null,
                  child:
                      user.imageUser == null
                          ? const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey,
                          )
                          : null,
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  user.email,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 10),

                buildUserInfoSection(
                  user: user,
                  dateFormat: dateFormat,
                  expiryDate: expiryDate,
                  isExpired: isExpired,
                ),
                const SizedBox(height: 12),

                /// زر تسجيل الخروج
                SizedBox(
                  width: double.infinity,
                  height: AppSize.buttonHeight,
                  child: ElevatedButton.icon(
                    onPressed: () => Get.offAll(() => const AuthScreen()),
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: Text(
                      "logout".tr,
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.radiusS),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildUserInfoSection({
    required user,
    required DateTime? expiryDate,
    required bool isExpired,
    required DateFormat dateFormat,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCardInfoTile(
          icon: Icons.phone,
          title: "phone_number".tr,
          value: user.phone ?? "unavailable".tr,
        ),
        _buildCardInfoTile(
          icon: Icons.home,
          title: "address".tr,
          value: user.address ?? "unavailable".tr,
        ),
        _buildCardInfoTile(
          icon: Icons.verified_user,
          title: "email_verified".tr,
          value: user.emailVerifiedAt != null ? "yes".tr : "no".tr,
          iconColor: user.emailVerifiedAt != null ? Colors.green : Colors.red,
        ),
        _buildCardInfoTile(
          icon: Icons.calendar_today,
          title: "creation_date".tr,
          value:
              user.createdAt != null
                  ? user.createdAt!.split('T').first
                  : "unavailable".tr,
        ),
        _buildCardInfoTile(
          icon: Icons.access_time_filled,
          title: "expiration_date".tr,
          value:
              expiryDate != null
                  ? dateFormat.format(expiryDate)
                  : "unavailable".tr,
          trailing: Chip(
            label: Text(
              isExpired ? "expired".tr : "valid".tr,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: isExpired ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildCardInfoTile({
    required IconData icon,
    required String title,
    required String value,
    Color iconColor = AppColors.primary,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 28),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColors.primary,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 14, color: AppColors.primary),
      ),
      trailing: trailing,
    );
  }
}
