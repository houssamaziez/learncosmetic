import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:learncosmetic/domain/repositories/category/category_repository_impl.dart';
import 'package:learncosmetic/presentation/controllers/category_controller.dart';
import 'package:learncosmetic/presentation/controllers/promotions_controller.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/banner_slider.dart';

import '../../data/models/promotion_banner.dart';
import '../../domain/repositories/promotion/promotion_repository_impl.dart';
import '../../domain/usecases/category.dart';
import '../../domain/usecases/promotion.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  var currentBannerIndex = 0.obs;
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void changeBannerIndex(int index) {
    currentBannerIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();

    final client = Client();

    Get.put(PromotionRepositoryImpl(client: client));
    Get.put(CategoryRepositoryImpl(client: client));

    Get.put(
      PromotionsController(PromotionUsecase(Get.find())),
    ).fetchPromotions();
    Get.put(CategoryController(CategoryUsecase(Get.find()))).fetchCategory();
  }
}
