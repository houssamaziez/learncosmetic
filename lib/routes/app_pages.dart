import 'package:get/get.dart';
import 'package:learncosmetic/presentation/admin/AddBookScreen.dart';
import 'package:learncosmetic/presentation/admin/AddPlaylistScreen.dart';
import 'package:learncosmetic/presentation/admin/AddPromotionScreen.dart';
import 'package:learncosmetic/presentation/admin/admin_add_category_screen.dart';
import 'package:learncosmetic/presentation/bindings/home_binding.dart';
import 'package:learncosmetic/presentation/bindings/splash_binding.dart';
import 'package:learncosmetic/presentation/screens/auth/auth_screen.dart';
import 'package:learncosmetic/presentation/screens/home/home_wrapper_screen.dart';
import 'package:learncosmetic/presentation/screens/splash/splash_screen.dart';

import '../presentation/admin/AddEpisodeScreen.dart';
import '../presentation/admin/HomeAdminScreen.dart';
import '../presentation/admin/screens/PromotionsListScreen.dart'
    show PromotionsListScreen;
import '../presentation/admin/screens/books.dart';
import '../presentation/admin/screens/categories.dart';
import '../presentation/admin/screens/episodes.dart';
import '../presentation/admin/screens/playlists.dart';
import '../presentation/bindings/login_binding.dart';
import '../presentation/screens/home/episode/episode_all.dart';
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
    GetPage(
      name: AppRoutes.addCategory,
      page: () => const AdminAddCategoryScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.addPlaylist,
      page: () => const AddPlaylistScreen(),
      binding: HomeBinding(),
    ),

    GetPage(name: AppRoutes.addEpisode, page: () => const AddEpisodeScreen()),
    GetPage(
      name: AppRoutes.addPromotions,
      page: () => const AddPromotionScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.addbooks,
      page: () => AddBookScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.homeAdmine,
      page: () => const HomeAdminScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.adminCategoryListVertical,
      page: () => const AdminCategoryListVertical(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.adminPlayListListVertical,
      page: () => const AdminPlayListListVertical(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.episodeListALll,
      page: () => AdminEpisodeListALll(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.adminBooks,
      page: () => const AdminBooksScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.adminPromotions,
      page: () => PromotionsListScreen(),
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
