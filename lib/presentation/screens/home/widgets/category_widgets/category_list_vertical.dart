import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/presentation/controllers/category_controller.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/category_widgets/playlist_category.dart';
import '../../../error/not_found_list.dart';
import 'category_item.dart';

class CategoryListVertical extends StatelessWidget {
  const CategoryListVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController controllerCategory =
        Get.find<CategoryController>();

    return Obx(() {
      if (controllerCategory.isLoading.value) {
        return const SizedBox(
          height: 180,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (controllerCategory.category.isEmpty) {
        return const SizedBox(height: 180, child: NotFoundScreenList());
      }

      return Scaffold(
        appBar: AppBar(title: const Text('All Categories')),
        body: SizedBox(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: controllerCategory.category.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // عدد الأعمدة
            ),
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
        ),
      );
    });
  }
}
