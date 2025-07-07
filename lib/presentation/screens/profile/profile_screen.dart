import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/presentation/screens/auth/auth_screen.dart';
import 'package:learncosmetic/presentation/screens/profile/update_user_profile_screen.dart'
    show UpdateUserProfileScreen;
import 'package:learncosmetic/presentation/widgets/spinkit.dart' show spinkit;

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_size.dart';
import '../../controllers/login_controller.dart'; // تأكد من أن AuthController يمتد من GetxController

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        final user = controller.user;

        if (user == null) {
          return Scaffold(body: Center(child: spinkit));
        }

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(UpdateUserProfileScreen(user: user));
                },
                icon: Icon(Icons.edit),
              ),
            ],
            title: const Text(
              'الصفحة الشخصية',
              style: TextStyle(color: AppColors.primary),
            ),
            centerTitle: true,
            backgroundColor: AppColors.primary.withOpacity(0.1),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.paddingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
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
                  const SizedBox(height: AppSize.spacingL),

                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: AppSize.fontSizeXL,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF540B0E),
                    ),
                  ),
                  const SizedBox(height: AppSize.spacingS),

                  Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: AppSize.fontSizeM,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: AppSize.spacingM),
                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('رقم الهاتف'),
                    subtitle: Text(user.phone ?? 'غير متوفر'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('العنوان'),
                    subtitle: Text(user.address ?? 'غير متوفر'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.verified_user),
                    title: const Text('تم التحقق من الإيميل'),
                    subtitle: Text(user.emailVerifiedAt != null ? 'نعم' : 'لا'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('تاريخ الإنشاء'),
                    subtitle: Text(
                      DateTime.parse(
                            user.createdAt!,
                          ).toLocal().toString().split(' ')[0] ??
                          '',
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    height: AppSize.buttonHeight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // controller.logout();

                        Get.offAll(AuthScreen());
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        'تسجيل الخروج',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF540B0E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.radiusS),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
