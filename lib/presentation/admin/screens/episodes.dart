import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:learncosmetic/presentation/widgets/play_video.dart'
    show VideoPlayerScreen;

import '../../../../core/constants/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../controllers/course_screen_controller.dart';
import '../../widgets/video_course_card.dart';
import '../controller/adminecontroller.dart';

class AdminEpisodeListALll extends StatefulWidget {
  @override
  State<AdminEpisodeListALll> createState() => _AdminEpisodeListALllState();
}

class _AdminEpisodeListALllState extends State<AdminEpisodeListALll> {
  final CourseScreenController controller = Get.find();
  @override
  void initState() {
    controller.getALLHomeEpisodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.addEpisode),
            icon: const Icon(Icons.add, color: Colors.black),
          ),
        ],
        title: const Text('كل الفيديوهات'),
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.1),
      ),
      body: GetBuilder<CourseScreenController>(
        init: controller,
        builder: (context) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.episodesHome.length,

            itemBuilder:
                (context, index) => Stack(
                  children: [
                    VideoCourseCard(
                      likes:
                          controller.episodesHome[index].likesCount.toString(),
                      course: controller.episodesHome[index],
                      onTap: () {
                        Get.to(
                          () => VideoPlayerScreen(
                            episode: controller.episodesHome[index],
                            videoUrl: controller.episodesHome[index].videoPath!,
                            title: controller.episodesHome[index].title,
                            description:
                                controller.episodesHome[index].description,
                          ),
                        );
                      },
                      title: controller.episodesHome[index].title,
                      views: Random().nextInt(500).toString(),
                      tag: controller.episodesHome[index].description,
                      imagePath: controller.episodesHome[index].imagePath,
                      commenter:
                          controller.episodesHome[index].commentsCount
                              .toString(),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,

                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          Get.put(AdminController())
                              .delete(
                                controller.episodesHome[index].id,
                                "episode",
                              )
                              .then((value) {
                                controller.getALLHomeEpisodes();
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
                ),
          );
        },
      ),
    );
  }
}
