import 'package:flutter/material.dart';
import 'package:learncosmetic/core/constants/app_size.dart';

class ButtonAll extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  const ButtonAll({
    super.key,
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF540B0E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.radiusM),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child:
            isLoading
                ? const SizedBox(
                  width: AppSize.buttonHeight,
                  height: AppSize.buttonHeight,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                : Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: AppSize.fontSizeM,
                  ),
                ),
      ),
    );
  }
}
