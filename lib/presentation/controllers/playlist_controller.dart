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
      throw Exception("playlist_not_found".tr);
    } finally {
      isLoading.value = false;
    }
  }

  /*************  ✨ Windsurf Command ⭐  *************/
  /// Fetches episodes based on the given playlist ID.
  ///
  /// This method updates the [isLoading] state to indicate the loading process
  /// and retrieves the list of episodes for the specified playlist ID using the
  /// [episodeUsecase]. The retrieved episodes are stored in [episodes] and also
  /// returned. If an error occurs while fetching, an exception is thrown with
  /// the message 'Playlist not found'.
  ///
  /// The [isLoading] state is reset to false once the operation is completed.
  ///

  /*******  b1ffaf20-ca1b-44c3-8b13-846f51961740  *******/
  Future<List<Episode>> getByIdPlaylist(int id) async {
    isLoading.value = true;
    try {
      final List<Episode>? result = await episodeUsecase(id);
      episodes.value = result!;
      update();
      return result;
    } catch (e) {
      throw Exception("playlist_not_found".tr);
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
        "not_allowed".tr,
        "complete_episodes_in_order".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    currentIndex.value = index;
    update();
  }
}
