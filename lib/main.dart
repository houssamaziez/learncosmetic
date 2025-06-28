import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:learncosmetic/core/services/local_storage_service.dart';
import 'package:learncosmetic/domain/repositories/user/user_repository_impl.dart';
import 'package:learncosmetic/domain/usecases/%20login_user.dart';
import 'package:learncosmetic/domain/usecases/register_user.dart';
import 'package:learncosmetic/presentation/controllers/login_controller.dart';
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

  final controller = AuthController(
    loginUser: usecaselogin,
    registerUser: usecaseregister,
  );

  Get.put(controller);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      unknownRoute: GetPage(
        name: AppRoutes.notFound,
        page: () => const NotFoundScreen(),
      ),
    );
  }
}
