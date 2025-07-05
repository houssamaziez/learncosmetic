import 'package:flutter/material.dart';
import 'package:learncosmetic/core/constants/api_constants.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.network(
                fit: BoxFit.cover,
                ApiConstants.host + "/" + icon,
                width: 10,
                height: 11,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
