import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/core/constants/api_constants.dart';
import 'package:learncosmetic/domain/usecases/category.dart';
import 'package:learncosmetic/domain/usecases/playlist.dart';
import 'package:learncosmetic/presentation/controllers/category_controller.dart';

import '../../playlist/screenplaylist.dart';
import '../playlist_widgets/popular_playlist_card.dart';

class PlaylistCategory extends StatelessWidget {
  final int id;

  PlaylistCategory({super.key, required this.id}) {
    Get.put(
      CategoryController(
        CategoryUsecase(Get.find()),
        PlaylistUsecase(Get.find()),
      ),
    ).fetchPlaylist(id);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Playlist Category')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.playlist.isEmpty) {
          return const Center(child: Text('لا توجد قوائم تشغيل'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.playlist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 3 / 4,
          ),
          itemBuilder: (context, index) {
            final item = controller.playlist[index];
            return PopularPlaylistCard(
              imagePath: (item.imageUrl ?? ''),
              subtitle: item.description ?? '',
              title: item.title ?? '',
              onTap: () {
                Get.to(CourseScreen(id: item.id.toString()));
              },
            );
          },
        );
      }),
    );
  }
}
