import 'package:flutter/material.dart';
import 'package:learncosmetic/core/constants/api_constants.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/core/constants/app_size.dart';
import 'package:learncosmetic/data/models/episode_model.dart';

class VideoCard extends StatelessWidget {
  final Episode video;
  final VoidCallback? onTap;

  const VideoCard({Key? key, required this.video, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.radiusM),
      child: Container(
        padding: const EdgeInsets.all(AppSize.paddingM),
        margin: const EdgeInsets.symmetric(vertical: AppSize.spacingXS),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.radiusM),
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.radiusS),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    ApiConstants.host + "/public/" + video.imagePath!,
                    width: 90,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  const Icon(
                    Icons.play_circle_fill,
                    color: Colors.white70,
                    size: 32,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSize.spacingM),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.fontSizeM,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSize.spacingXS),
                  // Text(
                  //   'أ. ${video.teacherName}',
                  //   style: const TextStyle(
                  //     fontSize: AppSize.fontSizeS,
                  //     color: AppColors.grey,
                  //   ),
                  // ),
                  const SizedBox(height: AppSize.spacingXS),
                  Text(
                    ' ${video.videoDuration} دقيقة',
                    style: const TextStyle(
                      fontSize: AppSize.fontSizeS,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
