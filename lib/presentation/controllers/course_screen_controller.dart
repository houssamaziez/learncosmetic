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

  CourseScreenController(this.playlistUsecase, this.episodeUsecase);

  List<Episode> episodes = [];
  int selectedIndex = 0;

  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  bool get isInitialized =>
      chewieController != null && videoPlayerController.value.isInitialized;
  bool isloading = false;
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

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}
