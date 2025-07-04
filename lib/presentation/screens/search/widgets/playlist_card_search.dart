import 'package:flutter/material.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/core/constants/app_size.dart';
import 'package:learncosmetic/data/models/playlist_model.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback? onTap;

  const PlaylistCard({Key? key, required this.playlist, this.onTap})
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
              child: Image.network(
                playlist.imageUrl!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: AppSize.spacingM),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playlist.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.fontSizeM,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSize.spacingXS),
                  Text(
                    '${playlist.description}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: AppSize.fontSizeS,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: AppSize.spacingXS),
                  Text(
                    '${playlist.coursesCount} فيديو · ${playlist.totalDuration} دقيقة',
                    style: const TextStyle(
                      fontSize: AppSize.fontSizeS,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.playlist_play, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
