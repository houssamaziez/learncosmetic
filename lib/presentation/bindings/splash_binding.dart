import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Registers SplashController with GetX dependency injection
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
