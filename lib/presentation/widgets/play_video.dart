import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/data/models/episode_model.dart';
import 'package:learncosmetic/presentation/controllers/course_screen_controller.dart';
import 'package:learncosmetic/presentation/widgets/spinkit.dart';
import 'package:video_player/video_player.dart';

import '../../core/constants/app_colors.dart';
import '../../domain/usecases/episode.dart';
import '../../domain/usecases/playlist.dart';
import '../controllers/playlist_controller.dart';
import '../screens/home/episode/episode_commenter_screen.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String description;
  final Episode episode;

  const VideoPlayerScreen({
    Key? key,
    required this.videoUrl,
    required this.title,
    required this.description,
    required this.episode,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool isLoading = true;
  final PlaylistController controllerplaylist = Get.put(
    PlaylistController(PlaylistUsecase(Get.find()), EpisodeUsecase(Get.find())),
  );

  final TextEditingController commentController = TextEditingController();

  void submitComment() {
    final text = commentController.text.trim();
    if (text.isEmpty) return;

    // TODO: Replace this with your real add-comment logic
    controllerplaylist.addEpisodeCommenter(widget.episode.id, text);

    commentController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    controllerplaylist.getEpisodeCommenter(widget.episode.id);
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);

    _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        allowMuting: true,
        allowPlaybackSpeedChanging: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.orangeAccent,
        ),
        placeholder: Container(color: Colors.black12),
        autoInitialize: true,
      );

      setState(() => isLoading = false);
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontSize: 18)),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: commentController,
                style: const TextStyle(fontFamily: 'Tajawal'),
                decoration: InputDecoration(
                  hintText: 'أضف تعليقك...',
                  hintStyle: const TextStyle(fontFamily: 'Tajawal'),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: submitComment,
              icon: const Icon(Icons.send, color: Colors.blue),
            ),
          ],
        ),
      ),

      body:
          isLoading
              ? Center(child: spinkit)
              : Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: Chewie(controller: _chewieController!),
                      ),

                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          widget.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            _tag(label: "جديد", color: Colors.red),
                            const SizedBox(width: 12),

                            const SizedBox(width: 12),
                            GetBuilder<CourseScreenController>(
                              builder: (controller) {
                                return InkWell(
                                  onTap:
                                      () => controller
                                          .addEpisodeLike(widget.episode.id)
                                          .then((value) {
                                            if (value == true) {
                                              widget.episode.likesCount++;
                                              controller.update();
                                            } else if (value == false) {
                                              widget.episode.likesCount--;
                                              controller.update();
                                            }
                                          }),
                                  child:
                                      controller.isLoadingAddlike
                                          ? SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: spinkit,
                                          )
                                          : _iconText(
                                            Icons.thumb_up_alt_outlined,
                                            widget.episode.likesCount
                                                .toString(),
                                          ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Obx(() {
                            if (controllerplaylist.isLoadingCommenter.value) {
                              return Center(child: spinkit);
                            }

                            if (controllerplaylist.commenter.isEmpty) {
                              return const Center(
                                child: Text(
                                  'لا توجد تعليقات حتى الآن',
                                  style: TextStyle(fontSize: 16),
                                ),
                              );
                            }

                            return Stack(
                              children: [
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(16),
                                  itemCount:
                                      controllerplaylist.commenter.length,
                                  separatorBuilder:
                                      (_, __) => const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    final comment =
                                        controllerplaylist.commenter[index];
                                    return CommentListTile(comment: comment);
                                  },
                                ),

                                if (controllerplaylist
                                    .isLoadingAddCommenter
                                    .value)
                                  Center(
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: spinkit,
                                    ),
                                  ),
                              ],
                            );
                          }),

                          // Input field
                        ],
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
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
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 13, color: AppColors.primary),
        ),
      ],
    );
  }
}
