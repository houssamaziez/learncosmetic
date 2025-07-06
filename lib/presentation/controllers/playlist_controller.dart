import 'package:get/get.dart';
import 'package:learncosmetic/data/models/episode_model.dart';
import 'package:learncosmetic/data/models/playlist_model.dart';

import '../../data/models/commenter.dart';
import '../../domain/usecases/episode.dart';
import '../../domain/usecases/playlist.dart';

class PlaylistController extends GetxController {
  final PlaylistUsecase playlistUsecase;
  final EpisodeUsecase episodeUsecase;

  PlaylistController(this.playlistUsecase, this.episodeUsecase);
  // Fields
  final isLoading = false.obs;
  final isLoadingCommenter = false.obs;
  final isLoadingAddCommenter = false.obs;
  final isLoadingAddlike = false.obs;
  final playlist = <Playlist>[].obs; // Example list of promotions
  final episodes = <Episode>[].obs; // Example list of episodes
  final commenter = <Commenter>[].obs; // Example list of episodes
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

  Future<void> getEpisodeCommenter(int id) async {
    isLoadingCommenter.value = true;
    commenter.value = [];
    try {
      final List<Commenter>? result = await episodeUsecase.getCommenter(id);
      commenter.value = result!;
      update();
    } catch (e) {
      throw Exception('Playlist not found');
    } finally {
      isLoadingCommenter.value = false;
    }
  }

  Future<List<Commenter>> addEpisodeCommenter(int id, String content) async {
    isLoadingAddCommenter.value = true;
    commenter.clear();

    try {
      await episodeUsecase
          .addCommenter(id, content)
          .then((value) => getEpisodeCommenter(id));
    } catch (e) {
      throw Exception('Commenter not sended');
    } finally {
      isLoadingAddCommenter.value = false;
      return commenter.value;
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
