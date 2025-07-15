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
            title: const Text(
              'الصفحة الشخصية',
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
                  radius: 55,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage:
                      user.imageUser != null
                          ? NetworkImage(user.imageUser!)
                          : null,
                  child:
                      user.imageUser == null
                          ? const Icon(
                            Icons.person,
                            size: 50,
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
                const SizedBox(height: 20),

                /// بطاقة معلومات
                Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    children: [
                      _buildInfoTile(
                        Icons.phone,
                        'رقم الهاتف',
                        user.phone ?? 'غير متوفر',
                      ),
                      _buildInfoTile(
                        Icons.home,
                        'العنوان',
                        user.address ?? 'غير متوفر',
                      ),
                      _buildInfoTile(
                        Icons.verified_user,
                        'تم التحقق من الإيميل',
                        user.emailVerifiedAt != null ? 'نعم' : 'لا',
                      ),
                      _buildInfoTile(
                        Icons.calendar_today,
                        'تاريخ الإنشاء',
                        user.createdAt != null
                            ? user.createdAt!.split('T').first
                            : 'غير متوفر',
                      ),
                      _buildInfoTile(
                        Icons.access_time_filled,
                        'تاريخ انتهاء الصلاحية',
                        expiryDate != null
                            ? dateFormat.format(expiryDate)
                            : 'غير متوفر',
                        trailing: Chip(
                          label: Text(
                            isExpired ? "انتهت الصلاحية" : "صالحة",
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor:
                              isExpired ? Colors.red : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                /// زر تسجيل الخروج
                SizedBox(
                  width: double.infinity,
                  height: AppSize.buttonHeight,
                  child: ElevatedButton.icon(
                    onPressed: () => Get.offAll(() => const AuthScreen()),
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      'تسجيل الخروج',
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

  Widget _buildInfoTile(
    IconData icon,
    String title,
    String subtitle, {
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing,
    );
  }
}
