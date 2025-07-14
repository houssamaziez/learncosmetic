import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:learncosmetic/presentation/widgets/play_video.dart'
    show VideoPlayerScreen;

import '../../../../core/constants/app_colors.dart';
import '../../controllers/course_screen_controller.dart';
import '../../widgets/video_course_card.dart';

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
        title: const Text('كل الفيديوهات'),
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.1),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.episodesHome.length,

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
              commenter:
                  controller.episodesHome[index].commentsCount.toString(),
            ),
      ),
    );
  }
}
