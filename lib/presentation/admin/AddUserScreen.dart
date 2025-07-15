import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';

import 'controller/adminecontroller.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  DateTime? expiryDate;
  final AdminController controller = Get.put(AdminController());

  bool isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || expiryDate == null) {
      Get.snackbar("تنبيه", "يرجى ملء جميع الحقول واختيار تاريخ الصلاحية");
      return;
    }

    setState(() => isLoading = true);

    final url = Uri.parse('https://test.hatlifood.com/api/register');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
      "expiry_date": DateFormat("yyyy-MM-dd").format(expiryDate!),
    });

    final request =
        http.Request('POST', url)
          ..headers.addAll(headers)
          ..body = body;

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "تم",
          "تم إضافة المستخدم بنجاح",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        controller.fetchUsers();
        Navigator.pop(context);
      } else {
        final data = jsonDecode(responseBody);
        Get.snackbar(
          "خطأ",
          data['message'] ?? "فشل الإضافة",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "خطأ",
        "فشل الاتصال بالخادم",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: expiryDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => expiryDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة مستخدم جديد"),
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField("الاسم الكامل", nameController),
              const SizedBox(height: 12),
              _buildField("البريد الإلكتروني", emailController, email: true),
              const SizedBox(height: 12),
              _buildField("كلمة المرور", passwordController, obscure: true),
              const SizedBox(height: 12),
              _buildField(
                "تأكيد كلمة المرور",
                confirmPasswordController,
                obscure: true,
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text(
                  expiryDate != null
                      ? "📅 تاريخ الانتهاء: ${DateFormat('yyyy-MM-dd').format(expiryDate!)}"
                      : "📅 اختر تاريخ انتهاء الصلاحية",
                ),
                trailing: const Icon(Icons.date_range),
                onTap: _pickDate,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF540B0E),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:
                    isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          "إضافة المستخدم",
                          style: TextStyle(color: Colors.white),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    bool email = false,
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: email ? TextInputType.emailAddress : TextInputType.text,
      obscureText: obscure,
      validator: (val) {
        if (val == null || val.isEmpty) return 'هذا الحقل مطلوب';
        if (email && !val.contains('@')) return 'بريد إلكتروني غير صالح';
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
