import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/presentation/controllers/login_controller.dart';
import '../../../../core/constants/app_size.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/button_all.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

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

        AppTextField(
          controller: controller.nameController,
          label: 'الاسم الكامل',
        ),
        const SizedBox(height: AppSize.spacingM),
        AppTextField(
          controller: controller.emailController,
          label: 'البريد الإلكتروني',
        ),
        const SizedBox(height: AppSize.spacingM),

        AppTextField(
          controller: controller.passwordController,
          label: 'كلمة المرور',
          isPassword: true,
        ),
        const SizedBox(height: AppSize.spacingM),

        AppTextField(
          controller: controller.confirmPasswordController,
          label: 'تأكيد كلمة المرور',
          isPassword: true,
        ),
        const SizedBox(height: AppSize.spacingL),

        // Register button
        Obx(
          () => ButtonAll(
            label: 'انشاء حساب',
            isLoading: controller.isLoading.value,
            onPressed: controller.register,
          ),
        ),
      ],
    );
  }
}
