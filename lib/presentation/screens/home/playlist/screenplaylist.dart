import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/domain/usecases/playlist.dart'
    show PlaylistUsecase;
import 'package:video_player/video_player.dart';
import '../../../../domain/usecases/episode.dart' show EpisodeUsecase;
import '../../../controllers/course_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../error/not_found_list.dart';

class CourseScreen extends StatefulWidget {
  final String id;
  const CourseScreen({super.key, required this.id});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.put(
      CourseScreenController(
        PlaylistUsecase(Get.find()),
        EpisodeUsecase(Get.find()),
      ),
    ).fetchEpisodes(widget.id);
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final controller = Get.find<CourseScreenController>();

    if (_scrollController.offset > 200 && !controller.isMiniPlayer) {
      controller.isMiniPlayer = true;
      controller.update();
    } else if (_scrollController.offset <= 200 && controller.isMiniPlayer) {
      controller.isMiniPlayer = false;
      controller.update();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(_handleScroll);
    final controller = Get.find<CourseScreenController>();
    controller.videoPlayerController.dispose();
    controller.chewieController?.dispose();
    controller.chewieController = null;
    controller.videoPlayerController = VideoPlayerController.network('');
    controller.episodes.clear();
    controller.selectedIndex = 0;
    controller.update();
    Get.delete<CourseScreenController>();
    // Dispose of the controller to free up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseScreenController>(
      builder: (controller) {
        if (controller.isloading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (controller.episodes.isEmpty) {
          return NotFoundScreenList();
        }

        final episode = controller.episodes[controller.selectedIndex];

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: _buildAppBar(),
            body: Stack(
              children: [
                Positioned.fill(
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      const SizedBox(height: 220), // مساحة الفيديو الكامل
                      _buildEpisodeInfo(episode),
                      const Divider(thickness: 1),
                      _buildSectionHeader(),
                      _buildEpisodeList(controller),
                    ],
                  ),
                ),
                GetBuilder<CourseScreenController>(
                  init: CourseScreenController(
                    PlaylistUsecase(Get.find()),
                    EpisodeUsecase(Get.find()),
                  ),
                  builder: (controllerbuild) {
                    return AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      top: controllerbuild.isMiniPlayer ? 20 : 0,
                      right: controllerbuild.isMiniPlayer ? 16 : null,
                      left:
                          controllerbuild.isMiniPlayer
                              ? null
                              : 0, // ← هذه تصبح null إذا كان mini
                      width:
                          controllerbuild.isMiniPlayer
                              ? 175
                              : MediaQuery.of(context).size.width,
                      height:
                          controllerbuild.isMiniPlayer
                              ? 90
                              : MediaQuery.of(context).size.width * 9 / 16,
                      child: GestureDetector(
                        onTap: () {
                          if (controllerbuild.isMiniPlayer) {
                            controllerbuild.isMiniPlayer = false;
                          }
                        },
                        child: Material(
                          elevation: controllerbuild.isMiniPlayer ? 6 : 0,
                          borderRadius: BorderRadius.circular(
                            controllerbuild.isMiniPlayer ? 12 : 0,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child:
                              controller.isInitialized
                                  ? Chewie(
                                    controller: controller.chewieController!,
                                  )
                                  : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 1,
      centerTitle: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'تعلم صنع مستحضرات التجميل',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Text(
            '3 مكتملة من 12',
            style: TextStyle(fontSize: 12, color: AppColors.primary),
          ),
        ],
      ),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Icon(Icons.more_vert, color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _buildEpisodeInfo(episode) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            episode.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _tag(label: "جديد", color: Colors.red),
              const SizedBox(width: 12),
              _iconText(Icons.visibility, "245"),
              const SizedBox(width: 12),
              _iconText(Icons.thumb_up_alt_outlined, "12"),
              const SizedBox(width: 12),
              _iconText(Icons.favorite_border, "24"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(Icons.play_circle_outline, color: Colors.red),
          SizedBox(width: 6),
          Text(
            'حلقات الدورة',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.primary,
            ),
          ),
          Spacer(),
          Icon(Icons.list, color: AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildEpisodeList(CourseScreenController controller) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 24),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.episodes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final episode = controller.episodes[index];
        final isSelected = index == controller.selectedIndex;

        return GestureDetector(
          onTap: () => controller.onEpisodeTap(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.red.withOpacity(0.07) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
              ],
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey.shade300,
                width: isSelected ? 1 : 1,
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    episode.imagePath,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        episode.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? AppColors.primary : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        episode.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      episode.videoDuration,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    if (episode.isWatched == true)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 18,
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _tag({required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 13, color: AppColors.primary),
        ),
      ],
    );
  }
}
