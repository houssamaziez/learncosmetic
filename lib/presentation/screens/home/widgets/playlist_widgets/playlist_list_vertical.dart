import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/presentation/controllers/category_controller.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/category_widgets/playlist_category.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/playlist_widgets/popular_playlist_card.dart'
    show PopularPlaylistCard;
import 'package:learncosmetic/presentation/widgets/spinkit.dart' show spinkit;
import '../../../../controllers/playlist_controller.dart';
import '../../../error/not_found_list.dart';
import '../../playlist/screenplaylist.dart';

class PlayListListVertical extends StatelessWidget {
  const PlayListListVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final PlaylistController controllerPlaylist =
        Get.find<PlaylistController>();

    return Obx(() {
      if (controllerPlaylist.isLoading.value) {
        return SizedBox(height: 180, child: Center(child: spinkit));
      }

      if (controllerPlaylist.playlist.isEmpty) {
        return const SizedBox(
          height: 180,
          child: Center(child: Text('No categories found')),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: Text("all_courses".tr),
          centerTitle: true,
          backgroundColor: AppColors.primary.withOpacity(0.1),
        ),
        body: SizedBox(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: controllerPlaylist.playlist.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 3 / 4,
            ),
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
        ),
      );
    });
  }
}
