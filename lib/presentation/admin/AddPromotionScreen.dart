import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../data/models/playlist_model.dart';

class AddPromotionScreen extends StatefulWidget {
  const AddPromotionScreen({super.key});

  @override
  State<AddPromotionScreen> createState() => _AddPromotionScreenState();
}

class _AddPromotionScreenState extends State<AddPromotionScreen> {
  final _formKey = GlobalKey<FormState>();

  String selectedCategoryName = 'اختر القسم';
  int? selectedCategoryId;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  File? selectedImage;

  bool isLoading = false;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _pickDate({required bool isStart}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? DateTime.now() : startDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  Future<List<Playlist>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('https://test.hatlifood.com/api/playlists'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data']; // حسب استجابة الـ API
      return data.map((e) => Playlist.fromJson(e)).toList();
    } else {
      throw Exception('فشل في تحميل الأقسام');
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() ||
        selectedImage == null ||
        startDate == null ||
        endDate == null) {
      Get.snackbar("خطأ", "يرجى ملء جميع الحقول واختيار صورة وتاريخين");
      return;
    }

    setState(() => isLoading = true);

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://test.hatlifood.com/api/promotions'),
      );

      request.fields.addAll({
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'start_date': DateFormat('yyyy/MM/dd').format(startDate!),
        'end_date': DateFormat('yyyy/MM/dd').format(endDate!),
        'playlist_id': selectedCategoryId.toString(),
      });

      request.files.add(
        await http.MultipartFile.fromPath('image', selectedImage!.path),
      );

      final response = await request.send();

      final body = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "نجاح",
          "تم إضافة العرض بنجاح",
          backgroundColor: Colors.green,
        );
        titleController.clear();
        descriptionController.clear();
        setState(() {
          selectedImage = null;
          startDate = null;
          endDate = null;
        });
      } else {
        Get.snackbar("فشل", body, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar(
        "خطأ",
        "حدث خطأ أثناء الإرسال",
        backgroundColor: Colors.redAccent,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  TextEditingController categoryIdController = TextEditingController();
  @override
  void initState() {
    fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text(
          "إضافة عرض ترويجي",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF540B0E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 12),

              GestureDetector(
                onTap: () => _showCategoryBottomSheet(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedCategoryName,
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              selectedCategoryId == null
                                  ? Colors.grey
                                  : Colors.black,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              _buildTextField("عنوان العرض", titleController),
              const SizedBox(height: 12),
              _buildTextField("وصف العرض", descriptionController, maxLines: 3),
              const SizedBox(height: 12),

              _buildDateSelector(
                "تاريخ البداية",
                startDate,
                () => _pickDate(isStart: true),
              ),
              const SizedBox(height: 12),
              _buildDateSelector(
                "تاريخ النهاية",
                endDate,
                () => _pickDate(isStart: false),
              ),
              const SizedBox(height: 12),

              _buildImagePicker(),

              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: isLoading ? null : _submit,
                icon: const Icon(Icons.upload, color: Colors.white),
                label:
                    isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          "رفع العرض",
                          style: TextStyle(color: Colors.white),
                        ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF540B0E),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: (val) => val == null || val.isEmpty ? "مطلوب" : null,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildDateSelector(String label, DateTime? date, VoidCallback onTap) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Colors.grey.shade100,
      title: Text(label),
      subtitle: Text(
        date != null ? DateFormat('yyyy/MM/dd').format(date) : "لم يتم التحديد",
      ),
      trailing: const Icon(Icons.date_range),
      onTap: onTap,
    );
  }

  Widget _buildImagePicker() {
    return InkWell(
      onTap: _pickImage,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child:
            selectedImage == null
                ? const Center(child: Text("اختر صورة العرض"))
                : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
      ),
    );
  }

  void _showCategoryBottomSheet(BuildContext context) async {
    try {
      List<Playlist> categories = await fetchCategories();
      List<Playlist> filteredList = [...categories];
      final searchController = TextEditingController();

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6, // 60% من الشاشة
            minChildSize: 0.4, // أدنى 40%
            maxChildSize: 0.9, // أقصى 90%
            expand: false,
            builder: (context, scrollController) {
              return StatefulBuilder(
                builder: (context, setModalState) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // 🔍 Search bar
                        TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'ابحث عن قسم...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (query) {
                            setModalState(() {
                              filteredList =
                                  categories
                                      .where(
                                        (cat) => cat.title
                                            .toLowerCase()
                                            .contains(query.toLowerCase()),
                                      )
                                      .toList();
                            });
                          },
                        ),
                        const SizedBox(height: 12),

                        // 🗂️ List of categories
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final category = filteredList[index];
                              return ListTile(
                                leading: const Icon(Icons.category),
                                title: Text(category.title),
                                onTap: () {
                                  setState(() {
                                    categoryIdController.text =
                                        category.id.toString();
                                    selectedCategoryId = category.id;
                                    selectedCategoryName = category.title;
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      );
    } catch (e) {
      Get.snackbar('خطأ', 'فشل تحميل الأقسام');
    }
  }
}
