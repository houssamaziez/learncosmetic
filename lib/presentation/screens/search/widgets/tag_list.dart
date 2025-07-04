import 'package:flutter/material.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/core/constants/app_size.dart';

class TagList extends StatelessWidget {
  final List<String> tags;
  final void Function(String)? onTagTap;
  final String? selectedTag;

  const TagList({Key? key, required this.tags, this.onTagTap, this.selectedTag})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.buttonHeight + 8,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingM),
        itemCount: tags.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSize.spacingS),
        itemBuilder: (context, index) {
          final tag = tags[index];
          final isSelected = tag == selectedTag;

          return GestureDetector(
            onTap: () => onTagTap?.call(tag),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.paddingM,
                vertical: AppSize.paddingS,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(AppSize.radiusM),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
