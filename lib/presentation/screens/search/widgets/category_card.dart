import 'package:flutter/material.dart';
import 'package:learncosmetic/core/constants/api_constants.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/core/constants/app_size.dart';
import 'package:learncosmetic/data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;

  const CategoryCard({Key? key, required this.category, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.radiusM),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSize.paddingM,
          horizontal: AppSize.paddingL,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.radiusM),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circle Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.network(
                ApiConstants.host + "/" + category.icon,
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(height: AppSize.spacingS),

            // Title
            Text(
              category.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppSize.fontSizeM,
              ),
            ),
            const SizedBox(height: 4),

            // Video count
            // Text(
            //   '${category.videoCount} فيديو',
            //   style: const TextStyle(
            //     color: AppColors.grey,
            //     fontSize: AppSize.fontSizeS,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
