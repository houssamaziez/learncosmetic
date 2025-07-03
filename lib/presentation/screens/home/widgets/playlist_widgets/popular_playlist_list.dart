import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/playlist_widgets/popular_playlist_card.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../controllers/playlist_controller.dart';
import '../../playlist/screenplaylist.dart';
import 'popular_playlist_list.dart';

class PopularPlayListList extends StatelessWidget {
  const PopularPlayListList({super.key});

  @override
  Widget build(BuildContext context) {
    final PlaylistController controllerPlaylist =
        Get.find<PlaylistController>();

    return Obx(() {
      if (controllerPlaylist.isLoading.value) {
        return const SizedBox(
          height: 180,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (controllerPlaylist.playlist.isEmpty) {
        return const SizedBox(
          height: 180,
          child: Center(child: Text('No categories found')),
        );
      }

      return SizedBox(
        height: 220,
        width: double.infinity,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controllerPlaylist.playlist.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final item = controllerPlaylist.playlist[index];
            return SizedBox(
              width: 180,
              child: PopularPlaylistCard(
                playlist: item,
                onTap: () {
                  Get.to(CourseScreen(id: item.id.toString()));
                },
              ),
            );
          },
        ),
      );
    });
  }
}
