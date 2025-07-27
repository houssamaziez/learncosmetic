import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/data/models/episode_model.dart';
import 'package:learncosmetic/domain/usecases/search.dart';
import '../../../data/models/playlist_model.dart';
import '../../../data/models/category_model.dart';

class AppSearchController extends GetxController {
  final SearchUsecase searchUsecase;
  final TextEditingController searchController = TextEditingController();

  AppSearchController(this.searchUsecase);
  var isLoading = true.obs;

  var playlists = <Playlist>[].obs;
  var videos = <Episode>[].obs;
  var categories = <CategoryModel>[].obs;
  var tags = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSearchData();
  }

  Future<void> fetchSearchData() async {
    try {
      isLoading.value = true;

      // tags.value = ['كريم أساس', 'بودرة', 'أحمر شفاه', 'ميكاج عيون', 'سيروم'];

      playlists.value = [];

      videos.value = [];

      categories.value = [];
    } catch (e) {
      Get.snackbar("error".tr, "data_load_failed".tr);
    } finally {
      isLoading.value = false;
    }
  }

  Timer? _debounce;

  void search(String keyword) {
    // إلغاء المؤقت السابق إن وجد
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(seconds: 2), () async {
      await _performSearch(keyword);
    });
  }

  Future<void> _performSearch(String keyword) async {
    if (keyword.trim().isEmpty) return;

    try {
      isLoading.value = true;

      final result = await searchUsecase(keyword.trim());

      playlists.value = result?.playlists ?? [];
      videos.value = result?.courses ?? [];
      categories.value = result?.categories ?? [];
      // tags.value = result?.tags ?? [];
    } catch (e) {
      Get.snackbar("error".tr, "data_load_failed".tr);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}
