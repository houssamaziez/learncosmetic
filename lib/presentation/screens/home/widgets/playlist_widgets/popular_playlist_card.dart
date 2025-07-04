import 'package:flutter/material.dart';
import 'package:learncosmetic/data/models/playlist_model.dart';

import '../../../../../core/utils/convert_time.dart';

class PopularPlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback? onTap;

  const PopularPlaylistCard({super.key, required this.playlist, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final double rating = 4.5;
    final int views = 1280;
    final String level = "مبتدئ";

    return Material(
      color: theme.cardColor,
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: theme.primaryColor.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.network(
                    playlist.imageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder:
                        (_, __, ___) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, size: 48),
                        ),
                  ),
                  // شريط علوي شفاف للمستوى
                  // Positioned(
                  //   top: 8,
                  //   left: 8,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 10,
                  //       vertical: 4,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: Colors.brown.withOpacity(0.9),
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: Text(
                  //       level,
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 12,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // تراكب سفلي فيه العنوان
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Text(
                        playlist.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(color: Colors.black38, blurRadius: 2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playlist.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.hintColor,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.play_circle_fill,
                            size: 18,
                            color: Colors.brown,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${playlist.coursesCount} دورة',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.brown,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            convertToReadableDuration(playlist.totalDuration),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // تقييم ومشاهدات
                  const SizedBox(height: 10),

                  // زر الإجراء
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF540B0E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('ابدأ التعلم الآن'),
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
