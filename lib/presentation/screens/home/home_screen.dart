import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/presentation/screens/home/episode/episode_all.dart'
    show EpisodeListALll;
import 'package:learncosmetic/presentation/screens/home/widgets/%20search_bar.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/banner_slider.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/category_widgets/category_list.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/playlist_widgets/playlist_list_vertical.dart'
    show PlayListListVertical;
import 'package:learncosmetic/presentation/screens/home/widgets/playlist_widgets/popular_playlist_list.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/custom_app_bar.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/section_header.dart';
import 'package:learncosmetic/presentation/widgets/video_course_card.dart';

import '../../controllers/course_screen_controller.dart';
import '../../widgets/play_video.dart';
import '../../widgets/spinkit.dart';
import 'widgets/category_widgets/category_list_vertical.dart'
    show CategoryListVertical;
import 'widgets/hi_user.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarHome(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HiUser(),
            const HomeSearchBar(),
            BannerSlider(),
            SectionHeader(
              title: "الأقسام الرئيسية",
              onSeeAll: () {
                Get.to(CategoryListVertical());
              },
            ),
            CategoryList(),
            SectionHeader(
              title: "الدورات الأكثر شعبية",
              onSeeAll: () {
                Get.to(PlayListListVertical());
              },
            ),
            PopularPlayListList(),

            GetBuilder<CourseScreenController>(
              builder: (controller) {
                if (controller.isloadingHome) {
                  return Center(child: spinkit);
                }
                if (controller.episodesHome.isEmpty) {
                  return const Center(
                    child: Text('لا توجد دورات متاحة حالياً'),
                  );
                }
                return Column(
                  children: [
                    SectionHeader(
                      title: 'الفيديو الأكثر شاهدة',
                      onSeeAll: () {
                        Get.to(EpisodeListALll(controller: controller));
                      },
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          controller.episodesHome.length > 4
                              ? 4
                              : controller.episodesHome.length,

                      itemBuilder:
                          (context, index) => VideoCourseCard(
                            likes:
                                controller.episodesHome[index].likesCount
                                    .toString(),
                            course: controller.episodesHome[index],
                            onTap: () {
                              Get.to(
                                () => VideoPlayerScreen(
                                  episode: controller.episodesHome[index],
                                  videoUrl:
                                      controller.episodesHome[index].videoPath!,
                                  title: controller.episodesHome[index].title,
                                  description:
                                      controller
                                          .episodesHome[index]
                                          .description,
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
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
