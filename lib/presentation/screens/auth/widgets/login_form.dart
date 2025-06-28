import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/constants/app_size.dart';
import '../../../controllers/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Error text
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

        // Email
        TextField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'البريد الإلكتروني',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: AppSize.spacingM),

        // Password
        TextField(
          controller: controller.passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'كلمة المرور',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: AppSize.spacingS),

        // Forgot password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Navigate to forgot password screen if needed
            },
            child: const Text('نسيت كلمة المرور؟'),
          ),
        ),

        const SizedBox(height: AppSize.spacingM),

        // Login button
        Obx(
          () => SizedBox(
            width: double.infinity,
            height: AppSize.buttonHeight,
            child: ElevatedButton(
              onPressed:
                  controller.isLoading.value
                      ? null
                      : () {
                        controller.login();
                      },
              child:
                  controller.isLoading.value
                      ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                      : const Text('تسجيل الدخول'),
            ),
          ),
        ),
      ],
    );
  }
}
