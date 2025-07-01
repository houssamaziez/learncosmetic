import 'package:flutter/material.dart';

class EpisodeListItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String duration;
  final EpisodeStatus status;
  final VoidCallback? onTap;

  const EpisodeListItem({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.duration,
    required this.status,
    this.onTap,
  }) : super(key: key);

  Color _statusColor() {
    switch (status) {
      case EpisodeStatus.completed:
        return Colors.green;
      case EpisodeStatus.locked:
        return Colors.grey;
      case EpisodeStatus.next:
        return Colors.blue;
    }
  }

  IconData _statusIcon() {
    switch (status) {
      case EpisodeStatus.completed:
        return Icons.check_circle;
      case EpisodeStatus.locked:
        return Icons.lock;
      case EpisodeStatus.next:
        return Icons.play_arrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: status != EpisodeStatus.locked ? onTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // صورة الحلقة
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            // النصوص
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // الحالة والمدة
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(_statusIcon(), color: _statusColor(), size: 20),
                const SizedBox(height: 8),
                Text(
                  duration,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// الحالة المحتملة للحلقة
enum EpisodeStatus { completed, next, locked }
