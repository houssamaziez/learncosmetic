import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../../../data/models/episode_model.dart';
import '../../../domain/usecases/episode.dart';
import '../../../domain/usecases/playlist.dart';

class CourseScreenController extends GetxController {
  final PlaylistUsecase playlistUsecase;
  final EpisodeUsecase episodeUsecase;
  bool isMiniPlayer = false;
  bool isLoadingAddlike = false;
  CourseScreenController(this.playlistUsecase, this.episodeUsecase);

  List<Episode> episodes = [];
  List<Episode> episodesHome = [];
  int selectedIndex = 0;

  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  bool get isInitialized =>
      chewieController != null && videoPlayerController.value.isInitialized;
  bool isloading = false;
  bool isloadingHome = false;
  Future<void> fetchEpisodes(String id) async {
    isloading = true;
    update();
    try {
      episodes = (await episodeUsecase(int.parse(id)))!;
      await initializePlayer(episodes[0].videoPath);
      update();
    } catch (e) {
      print('Error loading episodes: $e');
    } finally {
      isloading = false;
      update();
    }
  }

  Future<void> getALLHomeEpisodes() async {
    isloadingHome = true;
    update();
    try {
      episodesHome = (await episodeUsecase.getALL())!;
      update();
    } catch (e) {
      print('Error loading episodes: $e');
    } finally {
      isloadingHome = false;
      update();
    }
  }

  Future<void> initializePlayer(String url) async {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
    await videoPlayerController.initialize();

    chewieController?.dispose();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Get.theme.colorScheme.primary,
        handleColor: Get.theme.colorScheme.primary,
        backgroundColor: Get.theme.dividerColor,
        bufferedColor: Get.theme.colorScheme.primary.withOpacity(0.2),
      ),
    );
    update();
  }

  void onEpisodeTap(int index) async {
    final episode = episodes[index];
    if (index == selectedIndex ||
        episode.videoPath == null ||
        episode.videoPath!.isEmpty)
      return;

    try {
      selectedIndex = index;
      update();

      await videoPlayerController?.pause();
      await videoPlayerController?.dispose();
      chewieController?.dispose();

      videoPlayerController.dispose();
      chewieController = null;

      await initializePlayer(episode.videoPath!);
    } catch (e) {
      print("❌ Error switching episode: $e");
    }

    update();
  }

  Future<void> addEpisodeLike(int id) async {
    isLoadingAddlike = true;
    update();
    try {
      final result = await episodeUsecase.addLike(id);

      if (result == true || result == false) {
        for (int i = 0; i < episodes.length; i++) {
          if (episodes[i].id == id) {
            final updated = episodes[i].copyWith(
              likesCount:
                  result == true
                      ? episodes[i].likesCount + 1
                      : episodes[i].likesCount - 1,
            );
            episodes[i] = updated;
            update();
            break;
          }
        }
        update();
      }
    } catch (e) {
      throw Exception('like not sent');
    } finally {
      isLoadingAddlike = false;
      update();
    }
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}
