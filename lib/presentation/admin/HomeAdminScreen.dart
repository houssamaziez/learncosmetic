import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/presentation/controllers/home_controller.dart';

import '../../core/constants/app_colors.dart';
import '../../routes/app_routes.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  HomeController? controller;
  @override
  void initState() {
    controller = Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _AdminItem(title: 'الكتب', icon: Icons.book, route: AppRoutes.adminBooks),
      _AdminItem(
        title: 'الحلقات',
        icon: Icons.ondemand_video,
        route: AppRoutes.episodeListALll,
      ),
      _AdminItem(
        title: 'القوائم',
        icon: Icons.playlist_play,
        route: AppRoutes.adminPlayListListVertical,
      ),
      _AdminItem(
        title: 'العروض الترويجية',
        icon: Icons.campaign,
        route: AppRoutes.adminPromotions,
      ),
      _AdminItem(
        title: 'الأقسام',
        icon: Icons.category,
        route: AppRoutes.adminCategoryListVertical,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم'),
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return _AdminCard(item: items[index]);
          },
        ),
      ),
    );
  }
}

class _AdminItem {
  final String title;
  final IconData icon;
  final String route;

  _AdminItem({required this.title, required this.icon, required this.route});
}

class _AdminCard extends StatelessWidget {
  final _AdminItem item;

  const _AdminCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(item.route),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 40, color: Color(0xFF540B0E)),
            const SizedBox(height: 12),
            Text(
              item.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
