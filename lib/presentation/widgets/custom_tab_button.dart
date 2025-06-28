import 'package:flutter/material.dart';
import 'package:learncosmetic/core/constants/app_size.dart';

class CustomTabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTabButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: AppSize.buttonHeight,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF540B0E) : Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSize.radiusM),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
