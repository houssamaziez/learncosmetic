import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFoundScreenList extends StatelessWidget {
  const NotFoundScreenList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 100, color: Colors.grey.shade500),
            const SizedBox(height: 24),
            Text(
              "no_results".tr,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "no_matching_items".tr,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Get.back(); // أو Get.offAllNamed('/') للعودة للصفحة الرئيسية
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF540B0E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.arrow_back),
              label: Text("go_back".tr, style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
