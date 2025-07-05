import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/%20search_bar.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/banner_slider.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/category_widgets/category_list.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/playlist_widgets/popular_playlist_list.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/custom_app_bar.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/section_header.dart';

import 'widgets/category_widgets/category_list_vertical.dart'
    show CategoryListVertical;
import 'widgets/hi_user.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarHome(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HiUser(),
            const HomeSearchBar(),
            BannerSlider(),
            SectionHeader(
              title: "الأقسام الرئيسية",
              onSeeAll: () {
                Get.to(CategoryListVertical());
              },
            ),
            CategoryList(),
            SectionHeader(title: "الدورات الأكثر شعبية", onSeeAll: () {}),
            PopularPlayListList(),
            SectionHeader(title: "الدورات الأكثر شعبية", onSeeAll: () {}),
            PopularPlayListList(),
          ],
        ),
      ),
    );
  }
}
