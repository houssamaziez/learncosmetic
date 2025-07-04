import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/domain/usecases/search.dart';
import '../../domain/repositories/search/search_repository_impl.dart';
import '../controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    // تسجيل الريبو

    Get.lazyPut<SearchRepositoryImpl>(
      () => SearchRepositoryImpl(client: Get.find()),
    );

    // تسجيل اليوز كيس
    Get.lazyPut<SearchUsecase>(
      () => SearchUsecase(Get.find<SearchRepositoryImpl>()),
    );

    // تسجيل الكنترولر
    Get.lazyPut<AppSearchController>(
      () => AppSearchController(Get.find<SearchUsecase>()),
    );
  }
}
