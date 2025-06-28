import 'package:flutter/material.dart';
import '../../../../core/constants/app_size.dart';
import '../../../widgets/custom_tab_button.dart';

class LoginTabs extends StatelessWidget {
  final bool isLoginSelected;
  final VoidCallback onLoginTap;
  final VoidCallback onRegisterTap;

  const LoginTabs({
    Key? key,
    required this.isLoginSelected,
    required this.onLoginTap,
    required this.onRegisterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.buttonHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.radiusM),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: AppSize.radiusS,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(
        vertical: AppSize.paddingM,
        horizontal: AppSize.paddingL,
      ),
      child: Row(
        children: [
          CustomTabButton(
            label: 'تسجيل الدخول',
            isSelected: isLoginSelected,
            onTap: onLoginTap,
          ),
          CustomTabButton(
            label: 'إنشاء حساب',
            isSelected: !isLoginSelected,
            onTap: onRegisterTap,
          ),
        ],
      ),
    );
  }
}
