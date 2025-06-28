import 'package:flutter/material.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/%20search_bar.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/banner_slider.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/category_widgets/category_list.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/course_widgets/popular_course_card.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/custom_app_bar.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const CustomAppBar(),
            const HomeSearchBar(),
            BannerSlider(),
            SectionHeader(title: "الأقسام الرئيسية", onSeeAll: () {}),
            CategoryList(),
            SectionHeader(title: "الدورات الأكثر شعبية", onSeeAll: () {}),
            PopularCoursesList(),
          ],
        ),
      ),
    );
  }
}
