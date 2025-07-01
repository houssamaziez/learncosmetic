import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/core/constants/api_constants.dart';
import 'package:learncosmetic/presentation/controllers/playlist_controller.dart';
import 'episode_list_item.dart';

class EpisodeListView extends GetView<PlaylistController> {
  const EpisodeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.episodes.length,
        itemBuilder: (context, index) {
          final episode = controller.episodes[index];

          // تحديد حالة الحلقة
          final EpisodeStatus status;
          if (index < controller.currentIndex.value) {
            status = EpisodeStatus.completed;
          } else if (index == controller.currentIndex) {
            status = EpisodeStatus.next;
          } else {
            status = EpisodeStatus.locked;
          }

          return EpisodeListItem(
            title: episode.title,
            description: episode.description,
            imageUrl: ApiConstants.host + "/" + episode.imagePath,
            duration: episode.videoDuration,
            status: status,
            onTap: () => controller.setCurrentEpisode(index),
          );
        },
      );
    });
  }
}
