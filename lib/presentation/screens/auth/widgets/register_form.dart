import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/presentation/controllers/login_controller.dart';
import '../../../../core/constants/app_size.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Error message
        Obx(() {
          if (controller.loginError.isEmpty) return const SizedBox();
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSize.paddingS),
            child: Text(
              controller.loginError.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }),

        // Name field
        TextField(
          controller: controller.nameController,
          decoration: const InputDecoration(
            labelText: 'الاسم الكامل',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: AppSize.spacingM),

        // Email field
        TextField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'البريد الإلكتروني',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: AppSize.spacingM),

        // Password field
        TextField(
          controller: controller.passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'كلمة المرور',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: AppSize.spacingM),

        // Confirm password
        TextField(
          controller: controller.confirmPasswordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'تأكيد كلمة المرور',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: AppSize.spacingL),

        // Register button
        Obx(
          () => SizedBox(
            width: double.infinity,
            height: AppSize.buttonHeight,
            child: ElevatedButton(
              onPressed:
                  controller.isLoading.value
                      ? null
                      : () => controller.register(),
              child:
                  controller.isLoading.value
                      ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                      : const Text('إنشاء حساب'),
            ),
          ),
        ),
      ],
    );
  }
}
