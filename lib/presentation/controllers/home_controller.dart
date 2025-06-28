import 'package:get/get.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/banner_slider.dart';

import '../../data/models/promotion_banner.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  var banners = <PromotionBanner>[].obs;
  var currentBannerIndex = 0.obs;
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void loadBanners() {
    banners.value = [
      PromotionBanner(
        title: 'دورات مميزة',
        subtitle: 'تعلم أحدث تقنيات المكياج',
        image: 'assets/images/banner1.jpg',
      ),
      PromotionBanner(
        title: 'خصومات الصيف',
        subtitle: 'خصم 50% على منتجات البشرة',
        image: 'assets/images/banner2.jpg',
      ),
    ];
  }

  void changeBannerIndex(int index) {
    currentBannerIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    loadBanners();
  }
}
