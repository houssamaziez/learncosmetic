import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/presentation/controllers/category_controller.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/category_widgets/playlist_category.dart';
import 'package:learncosmetic/presentation/widgets/spinkit.dart' show spinkit;

import '../../../routes/app_routes.dart';
import '../../screens/error/not_found_list.dart';
import '../../screens/home/widgets/category_widgets/category_item.dart';
import '../controller/adminecontroller.dart';

class AdminCategoryListVertical extends StatelessWidget {
  const AdminCategoryListVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController controllerCategory =
        Get.find<CategoryController>();

    return Obx(() {
      if (controllerCategory.isLoading.value) {
        return Scaffold(
          body: SizedBox(height: 180, child: Center(child: spinkit)),
        );
      }

      if (controllerCategory.category.isEmpty) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () => Get.toNamed(AppRoutes.addCategory),
                icon: const Icon(Icons.add, color: Colors.black),
              ),
            ],
            title: const Text('كل الأقسام'),
            centerTitle: true,
            backgroundColor: AppColors.primary.withOpacity(0.1),
          ),
          body: const SizedBox(height: 180, child: NotFoundScreenList()),
        );
      }

      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(AppRoutes.addCategory),
              icon: const Icon(Icons.add, color: Colors.black),
            ),
          ],
          title: const Text('كل الأقسام'),
          centerTitle: true,
          backgroundColor: AppColors.primary.withOpacity(0.1),
        ),
        body: SizedBox(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: controllerCategory.category.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // عدد الأعمدة
            ),
            itemBuilder: (context, index) {
              final item = controllerCategory.category[index];
              return Stack(
                children: [
                  CategoryItem(
                    title: item.name as String,
                    icon: item.icon as String,
                    onTap: () {
                      Get.to(PlaylistCategory(id: item.id as int));
                    },
                  ),
                  Positioned(
                    top: 0,
                    right: 0,

                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Get.put(AdminController())
                            .delete(item.id, 'categories')
                            .then((value) {
                              controllerCategory.fetchCategory();
                            })
                            .catchError((error) {
                              Get.snackbar(
                                'خطاء',
                                'فشل الاتصال بالخادم',
                                backgroundColor:
                                    Get.theme.colorScheme.errorContainer,
                                colorText:
                                    Get.theme.colorScheme.onErrorContainer,
                              );
                            });
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
