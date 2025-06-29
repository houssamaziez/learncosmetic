import 'package:get/get.dart';
import '../../domain/usecases/promotion.dart';
import '../controllers/home_controller.dart';
import '../controllers/promotions_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(PromotionsController(PromotionUsecase(Get.find())));
  }
}
