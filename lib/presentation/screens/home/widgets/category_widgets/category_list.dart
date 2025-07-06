import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/presentation/controllers/category_controller.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/category_widgets/playlist_category.dart';
import '../../../../widgets/spinkit.dart';
import 'category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController controllerCategory =
        Get.find<CategoryController>();

    return Obx(() {
      if (controllerCategory.isLoading.value) {
        return SizedBox(height: 180, child: Center(child: spinkit));
      }

      if (controllerCategory.category.isEmpty) {
        return const SizedBox(
          height: 180,
          child: Center(child: Text('No categories found')),
        );
      }

      return SizedBox(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controllerCategory.category.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final item = controllerCategory.category[index];
            return CategoryItem(
              title: item.name as String,
              icon: item.icon as String,
              onTap: () {
                Get.to(PlaylistCategory(id: item.id as int));
              },
            );
          },
        ),
      );
    });
  }
}
