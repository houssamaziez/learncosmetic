import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/core/constants/api_constants.dart';
import 'package:learncosmetic/core/constants/app_size.dart';
import 'package:learncosmetic/presentation/controllers/playlist_controller.dart';
import 'package:learncosmetic/presentation/screens/home/playlist/widgets/episode_info_header.dart';
import 'package:learncosmetic/presentation/screens/home/playlist/widgets/episode_list_view.dart';
import 'package:learncosmetic/presentation/screens/home/playlist/widgets/video_player_section.dart';

class PlaylistScreenDetails extends GetView<PlaylistController> {
  const PlaylistScreenDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        controller.currentEpisode = controller.episodes.first;
        final episode = controller.currentEpisode;
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.paddingL,
                    vertical: AppSize.spacingS,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.more_vert),
                      Column(
                        children: [
                          const Text(
                            'تعلم صنع مستحضيق التجميل',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppSize.fontSizeM,
                            ),
                          ),
                          Text(
                            'الحلقة ${controller.currentIndex + 1} من ${controller.episodes.length}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),

                // مشغّل الفيديو
                VideoPlayerSection(
                  videoUrl: ApiConstants.host + "/" + episode!.videoPath,
                ),
                const SizedBox(height: AppSize.spacingM),

                // عنوان ومعلومات الفيديو
                EpisodeInfoHeader(
                  title: episode.title,
                  duration: episode.videoDuration,
                  likes: 1,
                  comments: 1,
                  reactions: 1,
                  hasSubtitles: true,
                ),

                const Divider(),

                // قائمة الحلقات
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.paddingL),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'حلقات الدورة',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.spacingS),

                const EpisodeListView(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
