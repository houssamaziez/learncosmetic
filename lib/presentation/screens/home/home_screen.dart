import 'package:flutter/material.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/%20search_bar.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/banner_slider.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/category_widgets/category_list.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/playlist_widgets/popular_playlist_list.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/custom_app_bar.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarHome(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                left: 16.0,
                top: 8,
                right: 16.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "أهلاً بكِ، سعاد!",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "استكشفي أحدث الدورات في عالم التجميل",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 65, 16, 20),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            const HomeSearchBar(),
            BannerSlider(),
            SectionHeader(title: "الأقسام الرئيسية", onSeeAll: () {}),
            CategoryList(),
            SectionHeader(title: "الدورات الأكثر شعبية", onSeeAll: () {}),
            PopularPlayListList(),
          ],
        ),
      ),
    );
  }
}
