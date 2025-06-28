import 'package:flutter/material.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/course_widgets/popular_courses_list.dart';
import 'popular_course_card.dart';

class PopularCoursesList extends StatelessWidget {
  const PopularCoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [
      {
        'title': 'أساسيات المكياج',
        'image': 'assets/images/course1.jpg',
        'subtitle': '40 د.ج',
      },
      {
        'title': 'تقنيات العناية بالبشرة',
        'image': 'assets/images/course2.jpg',
        'subtitle': 'مجاني',
      },
      {
        'title': 'تصميم الأظافر',
        'image': 'assets/images/course3.jpg',
        'subtitle': '100 د.ج',
      },
    ];

    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: courses.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = courses[index];
          return PopularCourseCard(
            title: item['title']!,
            imagePath: item['image']!,
            subtitle: item['subtitle']!,
            onTap: () {
              // open course details
            },
          );
        },
      ),
    );
  }
}
