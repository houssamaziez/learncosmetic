import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/presentation/controllers/category_controller.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/category_widgets/playlist_category.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/playlist_widgets/popular_playlist_card.dart'
    show PopularPlaylistCard;
import 'package:learncosmetic/presentation/widgets/spinkit.dart' show spinkit;

import '../../../routes/app_routes.dart';
import '../../controllers/playlist_controller.dart';
import '../../screens/home/playlist/screenplaylist.dart';
import '../controller/adminecontroller.dart';

class AdminPlayListListVertical extends StatelessWidget {
  const AdminPlayListListVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final PlaylistController controllerPlaylist =
        Get.find<PlaylistController>();

    return Obx(() {
      if (controllerPlaylist.isLoading.value) {
        return Scaffold(
          body: SizedBox(height: 180, child: Center(child: spinkit)),
        );
      }

      if (controllerPlaylist.playlist.isEmpty) {
        return SizedBox(
          height: 180,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () => Get.toNamed(AppRoutes.addPlaylist),
                  icon: const Icon(Icons.add, color: Colors.black),
                ),
              ],
              title: const Text('كل الدورات'),
              centerTitle: true,
              backgroundColor: AppColors.primary.withOpacity(0.1),
            ),
            body: Center(child: Text('No categories found')),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(AppRoutes.addPlaylist),
              icon: const Icon(Icons.add, color: Colors.black),
            ),
          ],
          title: const Text('كل الدورات'),
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
              return Stack(
                children: [
                  SizedBox(
                    width: 180,
                    child: PopularPlaylistCard(
                      playlist: item,
                      onTap: () {
                        Get.to(CourseScreen(id: item.id.toString()));
                      },
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,

                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Get.put(AdminController())
                            .delete(item.id, 'playlists')
                            .then((value) {
                              controllerPlaylist.fetchPlaylist();
                            })
                            .catchError((error) {
                              Get.snackbar(
                                'خطاء',
                                'فشل الاتصال بالخادم',
                                backgroundColor:
                                    Get.theme.colorScheme.errorContainer,
                                colorText:
                                    Get.theme.colorScheme.onErrorContainer,
                              );
                            });
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
