import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/formatDate.dart';
import '../../../data/models/promotion_banner.dart';
import '../../../domain/usecases/promotion.dart';
import '../../../routes/app_routes.dart';
import '../../controllers/promotions_controller.dart';
import '../../screens/home/playlist/screenplaylist.dart';
import '../controller/adminecontroller.dart';

class PromotionsListScreen extends StatelessWidget {
  final PromotionsController controller = Get.put(
    PromotionsController(PromotionUsecase(Get.find())),
  );

  PromotionsListScreen({super.key}) {
    controller.fetchPromotions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.addPromotions),
            icon: const Icon(Icons.add, color: Colors.black),
          ),
        ],
        title: const Text('العروض الترويجية'),
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.1),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.promotions.isEmpty) {
          return const Center(child: Text('لا توجد عروض حالياً'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.promotions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final PromotionBanner promo = controller.promotions[index];

            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (promo.image.isNotEmpty)
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.network(
                            '${ApiConstants.host}/${promo.image}',
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              promo.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF540B0E),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              promo.description,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'من ${promo.startDate != null ? formatDate(promo.startDate) : '---'}'
                                  ' إلى ${promo.endDate != null ? formatDate(promo.endDate) : '---'}',
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Get.to(
                                    CourseScreen(
                                      id: promo.playlistId.toString(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF540B0E),
                                ),
                                child: const Text('عرض الدورة المرتبطة'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: 0,
                  right: 0,

                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      Get.put(AdminController())
                          .delete(promo.id, 'promotions')
                          .then((value) {
                            controller.fetchPromotions();
                          })
                          .catchError((error) {
                            Get.snackbar(
                              'خطاء',
                              'فشل الاتصال بالخادم',
                              backgroundColor:
                                  Get.theme.colorScheme.errorContainer,
                              colorText: Get.theme.colorScheme.onErrorContainer,
                            );
                          });
                    },
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
