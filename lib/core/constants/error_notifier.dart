import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ErrorNotifier {
  /// Displays an error message using GetX snackbar.
  static void show(String message, {String title = 'Error'}) {
    if (message.isEmpty) return;

    Fluttertoast.showToast(
      msg: '$message',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red.shade100,
      textColor: Colors.red.shade900,
      timeInSecForIosWeb: 3,
    );
  }

  /// Displays a success message using GetX snackbar.
  static void showSuccess(String message, {String title = 'Success'}) {
    if (message.isEmpty) return;

    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade900,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
    );
  }

  /// Displays a warning message.
  static void showWarning(String message, {String title = 'Warning'}) {
    if (message.isEmpty) return;

    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.orange.shade100,
      colorText: Colors.orange.shade900,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
    );
  }
}
