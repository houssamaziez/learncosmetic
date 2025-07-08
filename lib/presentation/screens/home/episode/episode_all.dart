import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/presentation/screens/home/episode/episode_list_home.dart'
    show EpisodeListHome;

import '../../../../core/constants/app_colors.dart';
import '../../../../domain/usecases/episode.dart';
import '../../../../domain/usecases/playlist.dart';
import '../../../controllers/course_screen_controller.dart';
import '../../../widgets/play_video.dart';
import '../../../widgets/spinkit.dart';
import '../../../widgets/video_course_card.dart';

class EpisodeListALll extends StatefulWidget {
  EpisodeListALll({super.key, required this.controller});
  CourseScreenController controller;

  @override
  State<EpisodeListALll> createState() => _EpisodeListALllState();
}

class _EpisodeListALllState extends State<EpisodeListALll> {
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
        itemCount: widget.controller.episodesHome.length,

        itemBuilder:
            (context, index) => VideoCourseCard(
              likes:
                  widget.controller.episodesHome[index].likesCount.toString(),
              course: widget.controller.episodesHome[index],
              onTap: () {
                Get.to(
                  () => VideoPlayerScreen(
                    episode: widget.controller.episodesHome[index],
                    videoUrl: widget.controller.episodesHome[index].videoPath!,
                    title: widget.controller.episodesHome[index].title,
                    description:
                        widget.controller.episodesHome[index].description,
                  ),
                );
              },
              title: widget.controller.episodesHome[index].title,
              views: Random().nextInt(500).toString(),
              tag: widget.controller.episodesHome[index].description,
              imagePath: widget.controller.episodesHome[index].imagePath,
              commenter:
                  widget.controller.episodesHome[index].commentsCount
                      .toString(),
            ),
      ),
    );
  }
}
