import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/course_screen_controller.dart';
import '../../../widgets/play_video.dart';
import '../../../widgets/spinkit.dart';
import '../../../widgets/video_course_card.dart';

class EpisodeListHome extends StatelessWidget {
  const EpisodeListHome({super.key, required this.ishome});
  final bool ishome;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseScreenController>(
      builder: (controller) {
        if (controller.isloadingHome) {
          return Center(child: spinkit);
        }
        if (controller.episodesHome.isEmpty) {
          return Center(child: Text("no_courses_available".tr));
        }
        return ListView.builder(
          physics:
              !ishome
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:
              !ishome
                  ? controller.episodesHome.length
                  : controller.episodesHome.length > 4
                  ? 4
                  : controller.episodesHome.length,

          itemBuilder:
              (context, index) => VideoCourseCard(
                likes: controller.episodesHome[index].likesCount.toString(),
                course: controller.episodesHome[index],
                onTap: () {
                  Get.to(
                    () => VideoPlayerScreen(
                      episode: controller.episodesHome[index],
                      videoUrl: controller.episodesHome[index].videoPath!,
                      title: controller.episodesHome[index].title,
                      description: controller.episodesHome[index].description,
                    ),
                  );
                },
                title: controller.episodesHome[index].title,
                views: Random().nextInt(500).toString(),
                tag: controller.episodesHome[index].description,
                imagePath: controller.episodesHome[index].imagePath,
                commenter: controller.episodesHome[index].likesCount.toString(),
              ),
        );
      },
    );
  }
}
