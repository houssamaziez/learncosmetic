import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/data/models/user_model.dart';

class AdminController extends GetxController {
  final String baseUrl = 'https://test.hatlifood.com/api/';

  /// حذف عنصر بعد التأكيد
  Future<void> delete(int id, String path) async {
    final confirmed = await _showDeleteConfirmationDialog();
    if (confirmed) {
      await _performDelete(id, path);
    }
  }

  /// نافذة تأكيد الحذف
  Future<bool> _showDeleteConfirmationDialog() async {
    bool result = false;

    await Get.defaultDialog(
      title: 'تأكيد الحذف',
      middleText: 'هل أنت متأكد أنك تريد حذف هذا العنصر؟',
      confirmTextColor: Colors.white,
      cancelTextColor: AppColors.primary,
      textConfirm: 'نعم',
      textCancel: 'إلغاء',
      barrierDismissible: false,
      buttonColor: AppColors.primary,
      radius: 10,
      onConfirm: () {
        result = true;
        Get.back();
      },
      onCancel: () {
        result = false;
      },
    );

    return result;
  }

  /// تنفيذ طلب الحذف من API
  Future<void> _performDelete(int id, String path) async {
    final url = Uri.parse('$baseUrl$path/$id');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.snackbar(
          'تم الحذف',
          'تم حذف العنصر بنجاح.',
          backgroundColor: Colors.green.shade100,
          colorText: Colors.black87,
          duration: const Duration(seconds: 3),
        );
      } else {
        final data = json.decode(response.body);
        Get.snackbar(
          'فشل الحذف',
          data['message'] ?? 'حدث خطأ أثناء محاولة حذف العنصر.',
          backgroundColor: Colors.red.shade100,
          colorText: Colors.black87,
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل الاتصال بالخادم. حاول مرة أخرى.',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black87,
      );
    }
  }

  final RxList<UserModel> users = <UserModel>[].obs;
  final isLoading = false.obs;

  Future<void> fetchUsers() async {
    isLoading.value = true;
    final url = Uri.parse('https://test.hatlifood.com/api/users');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        users.assignAll(data.map((json) => UserModel.fromJson(json)).toList());
      } else {
        Get.snackbar('خطأ', 'فشل في جلب المستخدمين');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'فشل الاتصال بالخادم');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserExpiryDate(int userId, DateTime newDate) async {
    final url = Uri.parse('${baseUrl}users/update/$userId');
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(newDate);

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'expiry_date': formattedDate}),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "نجاح",
          "تم تحديث تاريخ الصلاحية",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        fetchUsers(); // لإعادة تحميل القائمة
      } else {
        Get.snackbar("خطأ", "فشل التحديث", backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      Get.snackbar(
        "استثناء",
        "تعذر الاتصال بالخادم",
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> removeUserDiveseId(int userId) async {
    final url = Uri.parse('${baseUrl}users/update/$userId');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'device_id': null}),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "نجاح",
          "تم تحديث",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        fetchUsers(); // لإعادة تحميل القائمة
      } else {
        Get.snackbar("خطأ", "فشل التحديث", backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      Get.snackbar(
        "استثناء",
        "تعذر الاتصال بالخادم",
        backgroundColor: Colors.red,
      );
    }
  }
}
