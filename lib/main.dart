import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:learncosmetic/core/services/local_storage_service.dart';
import 'package:learncosmetic/core/services/translations.dart';
import 'package:learncosmetic/domain/repositories/search/search_repository_impl.dart'
    show SearchRepositoryImpl;
import 'package:learncosmetic/domain/repositories/user/user_repository_impl.dart';
import 'package:learncosmetic/domain/usecases/%20login_user.dart';
import 'package:learncosmetic/domain/usecases/register_user.dart';
import 'package:learncosmetic/domain/usecases/search.dart';
import 'package:learncosmetic/presentation/controllers/login_controller.dart';
import 'package:learncosmetic/presentation/controllers/search_controller.dart';
import 'package:learncosmetic/presentation/screens/error/not_found_screen.dart';
import 'package:learncosmetic/routes/app_pages.dart';
import 'package:learncosmetic/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();

  final client = Client();
  final dataSource = UserRemoteDataSourceImpl(client);
  final repository = UserRemoteDataSourceImpl(client);
  final usecaselogin = LoginUser(repository);
  final usecaseregister = RegisterUser(repository);

  Get.put(SearchRepositoryImpl(client: client));
  Get.put(SearchUsecase(Get.find()));
  Get.put(AppSearchController(Get.find()));

  final controller = AuthController(
    loginUser: usecaselogin,
    registerUser: usecaseregister,
  );

  final storage = GetStorage();
  final String? langCode = storage.read('languageCode');
  final String? countryCode = storage.read('countryCode');

  Locale? initialLocale;
  if (langCode != null && countryCode != null) {
    initialLocale = Locale(langCode, countryCode);
  } else {
    initialLocale = const Locale('en', 'US'); // fallback if nothing stored
  }

  Get.put(controller);
  await AppTranslations.loadTranslations();
  await initializeDateFormatting(initialLocale.languageCode, null);

  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      translations: AppTranslations(),
      locale: initialLocale,
      fallbackLocale: const Locale('en', 'US'),
      getPages: AppPages.routes,
      unknownRoute: GetPage(
        name: AppRoutes.notFound,
        page: () => const NotFoundScreen(),
      ),
    );
  }
}
