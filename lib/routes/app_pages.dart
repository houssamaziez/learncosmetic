import 'package:get/get.dart';
import 'package:learncosmetic/presentation/bindings/splash_binding.dart';
import 'package:learncosmetic/presentation/screens/splash/splash_screen.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.login,
    //   page: () => const LoginScreen(),
    //   binding: LoginBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.home,
    //   page: () => const HomeScreen(),
    //   binding: HomeBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.profile,
    //   page: () => const ProfileScreen(),
    //   binding: ProfileBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.settings,
    //   page: () => const SettingsScreen(),
    //   binding: SettingsBinding(),
    // ),
    // GetPage(name: AppRoutes.notFound, page: () => const NotFoundScreen()),
  ];
}
