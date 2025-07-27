import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/core/constants/api_constants.dart';
import 'package:learncosmetic/domain/usecases/category.dart';
import 'package:learncosmetic/domain/usecases/playlist.dart';
import 'package:learncosmetic/presentation/controllers/category_controller.dart';
import 'package:learncosmetic/presentation/screens/error/not_found_list.dart'
    show NotFoundScreenList;

import '../../../../../core/constants/app_colors.dart';
import '../../../../widgets/spinkit.dart';
import '../../../error/not_found_screen.dart';
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
      appBar: AppBar(
        title: Text("courses".tr),
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.1),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: spinkit);
        }

        if (controller.playlist.isEmpty) {
          return NotFoundScreenList();
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
              playlist: item,
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
