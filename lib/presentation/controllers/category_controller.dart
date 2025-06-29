import 'dart:math';

import 'package:get/get.dart';
import 'package:learncosmetic/data/models/category_model.dart';
import 'package:learncosmetic/data/models/promotion_banner.dart';
import 'package:learncosmetic/domain/usecases/promotion.dart';

import '../../domain/usecases/category.dart';

class CategoryController extends GetxController {
  final CategoryUsecase categorysUsecase;

  CategoryController(this.categorysUsecase);
  // Fields
  final isLoading = false.obs;
  final promotions = <CategoryModel>[].obs; // Example list of promotions

  @override
  void onInit() {
    super.onInit();
    // fetchPromotions();
  }

  Future<List<CategoryModel>?> fetchPromotions() async {
    isLoading.value = true;
    try {
      // Simulate fetching promotions from a repository
      final List<CategoryModel>? result = await categorysUsecase();
      promotions.value = result!;
      return result;
    } catch (e) {
      throw Exception('PromotionBanner not found');
    } finally {
      isLoading.value = false;
    }
  }
}
