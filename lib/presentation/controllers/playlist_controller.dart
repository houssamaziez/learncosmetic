import 'package:get/get.dart';
import 'package:learncosmetic/data/models/playlist_model.dart';

import '../../domain/usecases/playlist.dart';

class PlaylistController extends GetxController {
  final PlaylistUsecase playlistUsecase;

  PlaylistController(this.playlistUsecase);
  // Fields
  final isLoading = false.obs;
  final playlist = <Playlist>[].obs; // Example list of promotions

  @override
  void onInit() {
    super.onInit();
    // fetchPromotions();
  }

  Future<List<Playlist>?> fetchPlaylist() async {
    isLoading.value = true;
    try {
      // Simulate fetching promotions from a repository
      final List<Playlist>? result = await playlistUsecase();
      playlist.value = result!;
      return result;
    } catch (e) {
      throw Exception('Playlist not found');
    } finally {
      isLoading.value = false;
    }
  }
}
