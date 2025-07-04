import 'package:flutter/material.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/core/constants/app_size.dart';

class SearchInput extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;

  SearchInput({super.key, this.onChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      focusNode: FocusNode(),

      decoration: InputDecoration(
        hintText: 'ابحث عن مستحضرات التجميل، فيديوهات، أو قوائم التشغيل...',
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppSize.paddingM,
          horizontal: AppSize.paddingM,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusM),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
