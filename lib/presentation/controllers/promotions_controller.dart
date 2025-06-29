import 'dart:math';

import 'package:get/get.dart';
import 'package:learncosmetic/data/models/promotion_banner.dart';
import 'package:learncosmetic/domain/usecases/promotion.dart';

class PromotionsController extends GetxController {
  final PromotionUsecase promotionUsecase;

  PromotionsController(this.promotionUsecase);
  // Fields
  final isLoading = false.obs;
  final promotions = <PromotionBanner>[].obs; // Example list of promotions

  @override
  void onInit() {
    super.onInit();
    // fetchPromotions();
  }

  Future<List<PromotionBanner>?> fetchPromotions() async {
    isLoading.value = true;
    try {
      // Simulate fetching promotions from a repository
      final List<PromotionBanner>? result = await promotionUsecase();
      promotions.value = result!;
      return result;
    } catch (e) {
      throw Exception('PromotionBanner not found');
    } finally {
      isLoading.value = false;
    }
  }
}
