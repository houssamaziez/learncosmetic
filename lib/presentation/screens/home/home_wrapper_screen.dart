import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/presentation/controllers/home_controller.dart';
import 'package:learncosmetic/presentation/screens/books/books_screen.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/bottom_nav_bar.dart';
import '../profile/profile_screen.dart';
import 'home_screen.dart';

class HomeWrapperScreen extends StatefulWidget {
  const HomeWrapperScreen({super.key});

  @override
  State<HomeWrapperScreen> createState() => _HomeWrapperScreenState();
}

class _HomeWrapperScreenState extends State<HomeWrapperScreen> {
  final HomeController controller = Get.put(HomeController());
  late final PageController _pageController;

  final _pages = [HomeScreen(), BooksScreen(), UserProfileScreen()];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: controller.selectedIndex.value,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),

          pageSnapping: true,
          controller: _pageController,
          onPageChanged: (index) {
            controller.selectedIndex.value = index;
          },
          children: _pages,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.selectedIndex.value = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      );
    });
  }
}
