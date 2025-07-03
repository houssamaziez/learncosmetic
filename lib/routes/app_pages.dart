import 'package:get/get.dart';
import 'package:learncosmetic/presentation/bindings/home_binding.dart';
import 'package:learncosmetic/presentation/bindings/splash_binding.dart';
import 'package:learncosmetic/presentation/screens/auth/auth_screen.dart';
import 'package:learncosmetic/presentation/screens/home/home_wrapper_screen.dart';
import 'package:learncosmetic/presentation/screens/splash/splash_screen.dart';

import '../presentation/bindings/login_binding.dart';
import '../presentation/screens/home/playlist/screenplaylist.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const AuthScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeWrapperScreen(),
      binding: HomeBinding(),
    ),

    // GetPage(
    //   name: AppRoutes.settings,
    //   page: () => const SettingsScreen(),
    //   binding: SettingsBinding(),
    // ),
    // GetPage(name: AppRoutes.notFound, page: () => const NotFoundScreen()),
  ];
}
