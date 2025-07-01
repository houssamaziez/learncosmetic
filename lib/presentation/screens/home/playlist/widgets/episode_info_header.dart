import 'package:flutter/material.dart';

class EpisodeInfoHeader extends StatelessWidget {
  final String title;
  final String duration;
  final int likes;
  final int comments;
  final int reactions;
  final bool hasSubtitles;

  const EpisodeInfoHeader({
    Key? key,
    required this.title,
    required this.duration,
    required this.likes,
    required this.comments,
    required this.reactions,
    this.hasSubtitles = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان الفيديو
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              // زر الترجمة
              if (hasSubtitles)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.translate, size: 16),
                      SizedBox(width: 4),
                      Text("ترجمة", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),

              const SizedBox(width: 12),

              // إعجابات
              Icon(Icons.favorite_border, size: 18),
              const SizedBox(width: 4),
              Text('$likes'),

              const SizedBox(width: 12),

              // تعليقات
              Icon(Icons.comment_outlined, size: 18),
              const SizedBox(width: 4),
              Text('$comments'),

              const SizedBox(width: 12),

              // تفاعلات عامة
              Icon(Icons.thumb_up_alt_outlined, size: 18),
              const SizedBox(width: 4),
              Text('$reactions'),

              const Spacer(),

              // المدة
              Text(duration, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
