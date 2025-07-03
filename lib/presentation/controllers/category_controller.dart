import 'dart:math';

import 'package:get/get.dart';
import 'package:learncosmetic/data/models/category_model.dart';
import 'package:learncosmetic/data/models/promotion_banner.dart';
import 'package:learncosmetic/domain/usecases/promotion.dart';

import '../../data/models/playlist_model.dart';
import '../../domain/usecases/category.dart';
import '../../domain/usecases/playlist.dart';

class CategoryController extends GetxController {
  final CategoryUsecase categorysUsecase;
  final PlaylistUsecase playlistUsecase;

  CategoryController(this.categorysUsecase, this.playlistUsecase);
  // Fields
  final isLoading = false.obs;
  final category = <CategoryModel>[].obs; // Example list of promotions

  @override
  void onInit() {
    super.onInit();
    // fetchPromotions();
  }

  Future<List<CategoryModel>?> fetchCategory() async {
    isLoading.value = true;
    try {
      // Simulate fetching promotions from a repository
      final List<CategoryModel>? result = await categorysUsecase();
      category.value = result!;
      return result;
    } catch (e) {
      throw Exception('PromotionBanner not found');
    } finally {
      isLoading.value = false;
    }
  }

  final playlist = <Playlist>[].obs;

  Future<List<Playlist>?> fetchPlaylist(int id) async {
    isLoading.value = true;
    update();

    try {
      // Simulate fetching promotions from a repository
      final List<Playlist>? result = await playlistUsecase.getbyId(id);
      playlist.value = result!;
      update();
      return result;
    } catch (e) {
      throw Exception('Playlist not found');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
