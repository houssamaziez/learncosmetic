import 'package:flutter/material.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/core/constants/app_size.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final IconData? icon;

  const SectionTitle({Key? key, required this.title, this.onTap, this.icon})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: AppSize.fontSizeL,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
