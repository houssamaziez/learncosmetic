import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../bindings/search_binding.dart';
import '../../search/search_screen.dart';

class HomeSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const HomeSearchBar({super.key, this.onChanged, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(SearchScreen(), binding: SearchBinding()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: GestureDetector(
          onTap: () => Get.to(SearchScreen()),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Text(
                  "search_hint_courses_products".tr,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
