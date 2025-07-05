import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/core/constants/app_assets.dart';
import 'package:learncosmetic/presentation/screens/error/not_found_list.dart';
import 'package:learncosmetic/presentation/screens/home/playlist/screenplaylist.dart';
import 'package:learncosmetic/presentation/screens/search/widgets/category_card.dart';
import 'package:learncosmetic/presentation/screens/search/widgets/playlist_card_search.dart';
import 'package:learncosmetic/presentation/screens/search/widgets/search_input.dart'
    show SearchInput;
import 'package:learncosmetic/presentation/screens/search/widgets/section_title.dart';
import 'package:learncosmetic/presentation/screens/search/widgets/tag_list.dart';
import 'package:learncosmetic/presentation/screens/search/widgets/video_card.dart';
import '../../../core/constants/app_size.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/usecases/search.dart';
import '../../controllers/search_controller.dart';
import '../../widgets/play_video.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late AppSearchController controller;
  @override
  void initState() {
    controller = Get.put(AppSearchController(SearchUsecase(Get.find())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بحث'),

        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(AppSize.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SearchInput(
                      controller: controller.searchController,
                      onChanged: (p0) {
                        controller.search(p0);
                      },
                    ),

                    const SizedBox(height: AppSize.spacingM),
                    (controller.videos.isEmpty &&
                            controller.playlists.isEmpty &&
                            controller.categories.isEmpty &&
                            controller.searchController.text.isNotEmpty)
                        ? NotFoundScreenList()
                        : Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Image.asset(AppAssets.search, height: 400),
                          ),
                        ),

                    // TagList(tags: controller.tags),
                    const SizedBox(height: AppSize.spacingS),
                    if (controller.playlists.isNotEmpty)
                      const SectionTitle(
                        title: 'قوائم التشغيل',
                        icon: Icons.playlist_play,
                      ),

                    const SizedBox(height: AppSize.spacingS),
                    if (controller.playlists.isNotEmpty)
                      Column(
                        children:
                            controller.playlists.map((playlist) {
                              return PlaylistCard(
                                playlist: playlist,
                                onTap:
                                    () => Get.to(
                                      CourseScreen(id: playlist.id.toString()),
                                    ),
                              );
                            }).toList(),
                      ),
                    if (controller.categories.isNotEmpty)
                      const SizedBox(height: AppSize.spacingL),

                    if (controller.videos.isNotEmpty)
                      const SectionTitle(
                        title: 'الفيديوهات',
                        icon: Icons.play_arrow,
                      ),
                    const SizedBox(height: AppSize.spacingS),
                    Column(
                      children:
                          controller.videos.map((video) {
                            return VideoCard(
                              video: video,
                              onTap: () {
                                Get.to(
                                  () => VideoPlayerScreen(
                                    videoUrl: video.videoPath!,
                                    title: video.title,
                                    description: video.description,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                    ),

                    const SizedBox(height: AppSize.spacingL),

                    if (controller.categories.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SectionTitle(
                            title: 'الفئات',
                            icon: Icons.grid_view,
                          ),
                          const SizedBox(height: AppSize.spacingS),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.4,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                            itemCount: controller.categories.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                category: controller.categories[index],
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              );
        }),
      ),
    );
  }
}
