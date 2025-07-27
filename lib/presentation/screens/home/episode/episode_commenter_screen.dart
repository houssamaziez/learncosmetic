import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learncosmetic/domain/usecases/episode.dart' show EpisodeUsecase;
import 'package:learncosmetic/domain/usecases/playlist.dart';
import 'package:learncosmetic/presentation/widgets/spinkit.dart' show spinkit;

import '../../../../data/models/commenter.dart';
import '../../../controllers/playlist_controller.dart';

class EpisodeCommenterScreen extends StatefulWidget {
  final int episodeId;

  EpisodeCommenterScreen({super.key, required this.episodeId});

  @override
  State<EpisodeCommenterScreen> createState() => _EpisodeCommenterScreenState();
}

class _EpisodeCommenterScreenState extends State<EpisodeCommenterScreen> {
  final PlaylistController controller = Get.put(
    PlaylistController(PlaylistUsecase(Get.find()), EpisodeUsecase(Get.find())),
  );

  final TextEditingController commentController = TextEditingController();

  void submitComment() {
    final text = commentController.text.trim();
    if (text.isEmpty) return;

    // TODO: Replace this with your real add-comment logic
    controller.addEpisodeCommenter(widget.episodeId, text);

    commentController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    controller.getEpisodeCommenter(widget.episodeId);

    return Scaffold(
      appBar: AppBar(
        title: Text("comments".tr, style: TextStyle(fontFamily: 'Tajawal')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoadingCommenter.value) {
                return Center(child: spinkit);
              }

              if (controller.commenter.isEmpty) {
                return Center(
                  child: Text(
                    "no_comments_yet".tr,
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return Stack(
                children: [
                  ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.commenter.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final comment = controller.commenter[index];
                      return CommentListTile(comment: comment);
                    },
                  ),

                  if (controller.isLoadingAddCommenter.value)
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
          ),

          // Input field
          Container(
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
                      hintText: "add_your_comment".tr,
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
        ],
      ),
    );
  }
}

class CommentListTile extends StatelessWidget {
  final Commenter comment;

  const CommentListTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    String firstLetter =
        comment.userName.trim().isNotEmpty
            ? comment.userName.trim()[0].toUpperCase()
            : '?';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circle Avatar with first letter
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blue.shade100,
            backgroundImage:
                (comment.userImage != null && comment.userImage!.isNotEmpty)
                    ? NetworkImage(comment.userImage!)
                    : null,
            child:
                (comment.userImage == null || comment.userImage!.isEmpty)
                    ? Text(
                      firstLetter,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    )
                    : null,
          ),
          const SizedBox(width: 12),
          // Comment content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Tajawal',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  comment.content,
                  style: const TextStyle(fontSize: 14, fontFamily: 'Tajawal'),
                ),
                const SizedBox(height: 8),
                Text(
                  DateFormat('yyyy/MM/dd HH:mm').format(comment.createdAt),
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
