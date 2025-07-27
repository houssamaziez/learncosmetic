import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/constants/app_size.dart';
import '../../../controllers/login_controller.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/button_all.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

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
        // TextField(
        //   controller: controller.emailController,
        //   keyboardType: TextInputType.emailAddress,
        //   decoration: const InputDecoration(
        //     labelText: 'البريد الإلكتروني',
        //     border: OutlineInputBorder(),
        //   ),
        // ),
        AppTextField(
          controller: controller.emailController,
          label: "email".tr,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSize.spacingM),

        // Password
        // TextField(
        //   controller: controller.passwordController,
        //   obscureText: true,
        //   decoration: const InputDecoration(
        //     labelText: 'كلمة المرور',
        //     border: OutlineInputBorder(),
        //   ),
        // ),
        AppTextField(
          controller: controller.passwordController,
          label: "password".tr,
          isPassword: true,
        ),
        const SizedBox(height: AppSize.spacingS),

        // Forgot password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Navigate to forgot password screen if needed
            },
            child: Text("forgot_password".tr),
          ),
        ),

        const SizedBox(height: AppSize.spacingM),

        // Login button
        Obx(
          () => ButtonAll(
            label: "login".tr,
            isLoading: controller.isLoading.value,
            onPressed: controller.login,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          color: Colors.white,
        ),
      ],
    );
  }
}
