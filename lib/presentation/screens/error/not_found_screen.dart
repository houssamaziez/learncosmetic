import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.red.shade400),
            const SizedBox(height: 16),
            Text(
              "404_page_not_found".tr,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "page_not_found".tr,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // ElevatedButton(
            //   onPressed: () => Get.offAllNamed('/'),
            //   child: const Text('Go to Home'),
            // ),
          ],
        ),
      ),
    );
  }
}
