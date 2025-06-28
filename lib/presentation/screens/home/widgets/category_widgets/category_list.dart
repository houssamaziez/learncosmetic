import 'package:flutter/material.dart';
import 'category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'مكياج', 'icon': Icons.brush},
      {'title': 'عطور', 'icon': Icons.local_florist},
      {'title': 'العناية بالبشرة', 'icon': Icons.spa},
      {'title': 'العناية بالشعر', 'icon': Icons.water_drop},
      {
        'title': 'أظافر',
        'icon': Icons.star,
      }, // using Icons.star as a substitute
    ];

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = categories[index];
          return CategoryItem(
            title: item['title'] as String,
            icon: item['icon'] as IconData,
            onTap: () {
              // Handle category tap
            },
          );
        },
      ),
    );
  }
}
