import 'package:get/get.dart';
import 'package:learncosmetic/data/models/episode_model.dart';
import 'package:learncosmetic/data/models/playlist_model.dart';

import '../../domain/usecases/episode.dart';
import '../../domain/usecases/playlist.dart';

class PlaylistController extends GetxController {
  final PlaylistUsecase playlistUsecase;
  final EpisodeUsecase episodeUsecase;

  PlaylistController(this.playlistUsecase, this.episodeUsecase);
  // Fields
  final isLoading = false.obs;
  final playlist = <Playlist>[].obs; // Example list of promotions
  final episodes = <Episode>[].obs; // Example list of episodes
  final currentIndex = 0.obs;
  Episode? currentEpisode;

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

  Future<List<Episode>> getByIdPlaylist(int id) async {
    isLoading.value = true;
    try {
      final List<Episode>? result = await episodeUsecase(id);
      episodes.value = result!;
      update();

      return result;
    } catch (e) {
      throw Exception('Playlist not found');
    } finally {
      isLoading.value = false;
      return episodes;
    }
  }

  void setCurrentEpisode(int index) {
    if (index < 0 || index >= episodes.length) return;

    if (index > currentIndex.value + 1) {
      Get.snackbar(
        'غير مسموح',
        'يجب إكمال الحلقات بالترتيب',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    currentIndex.value = index;
    update();
  }
}
