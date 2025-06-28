import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_size.dart';
import '../../controllers/login_controller.dart';
import '../../widgets/language_selector.dart';
import 'widgets/login_tabs.dart';
import 'widgets/login_form.dart';
import 'widgets/register_form.dart';

class AuthScreen extends GetView<LoginController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF540B0E),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSize.spacingL),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSize.paddingM),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSize.radiusM),
                  ),
                  child: const Icon(
                    Icons.palette,
                    size: AppSize.iconSizeL,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSize.spacingS),
                const Text(
                  'Learn Cosmetic',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSize.spacingXS),
                const Text(
                  'اكتشفي عالم الجمال والتجميل',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: AppSize.spacingL),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.paddingL,
                  vertical: AppSize.paddingM,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppSize.radiusXL),
                  ),
                ),
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoginTabs(
                        isLoginSelected: controller.isLogin.value,
                        onLoginTap: () => controller.setLogin(true),
                        onRegisterTap: () => controller.setLogin(false),
                      ),
                      const SizedBox(height: AppSize.spacingM),
                      controller.isLogin.value
                          ? const LoginForm()
                          : const RegisterForm(),
                    ],
                  );
                }),
              ),
            ),
            const LanguageSelector(),
          ],
        ),
      ),
    );
  }
}
