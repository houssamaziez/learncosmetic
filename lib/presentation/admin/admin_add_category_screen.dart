import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/presentation/controllers/category_controller.dart';
import 'package:path/path.dart' as path;

class AdminAddCategoryScreen extends StatefulWidget {
  const AdminAddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AdminAddCategoryScreen> createState() => _AdminAddCategoryScreenState();
}

class _AdminAddCategoryScreenState extends State<AdminAddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  File? _selectedImage;
  bool isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  final CategoryController controllerCategory = Get.find<CategoryController>();
  Future<void> _submitCategory() async {
    if (!_formKey.currentState!.validate() || _selectedImage == null) return;

    setState(() => isLoading = true);

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://test.hatlifood.com/api/categories'),
      );
      request.fields.addAll({
        'name': nameController.text,
        'description': descriptionController.text,
      });
      request.files.add(
        await http.MultipartFile.fromPath(
          'icon',
          _selectedImage!.path,
          filename: path.basename(_selectedImage!.path),
        ),
      );

      var response = await request.send();

      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        controllerCategory.fetchCategory();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('تمت إضافة التصنيف بنجاح')));
        nameController.clear();
        descriptionController.clear();
        setState(() => _selectedImage = null);
        Get.back();
      } else {
        final body = await response.stream.bytesToString();
        print('Error ${response.statusCode}: $body');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل الإضافة: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطأ أثناء الإرسال: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة تصنيف جديد'),
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم التصنيف',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) => value == null || value.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'الوصف',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator:
                    (value) => value == null || value.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100],
                  ),
                  child:
                      _selectedImage == null
                          ? const Center(child: Text('اختر صورة'))
                          : Image.file(_selectedImage!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : _submitCategory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF540B0E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label:
                      isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            'إضافة',
                            style: TextStyle(color: Colors.white),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
