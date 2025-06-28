import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/presentation/controllers/home_controller.dart';
import 'package:learncosmetic/presentation/screens/home/widgets/bottom_nav_bar.dart';

// صفحاتك
import 'home_screen.dart';

class HomeWrapperScreen extends GetView<HomeController> {
  HomeWrapperScreen({super.key});

  final _pages = [
    HomeScreen(),
    // CoursesScreen(),
    // CartScreen(),
    // ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: _pages[controller.selectedIndex.value],
        bottomNavigationBar: CustomBottomNavBar(),
      );
    });
  }
}
