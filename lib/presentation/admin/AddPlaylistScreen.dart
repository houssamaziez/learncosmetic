import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';

import '../../data/models/category_model.dart';

class AddPlaylistScreen extends StatefulWidget {
  const AddPlaylistScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaylistScreen> createState() => _AddPlaylistScreenState();
}

class _AddPlaylistScreenState extends State<AddPlaylistScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('https://test.hatlifood.com/api/categories'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data']; // حسب استجابة الـ API
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('فشل في تحميل الأقسام');
    }
  }

  File? imageFile;
  bool isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || imageFile == null) {
      Get.snackbar("خطأ", "يرجى ملء جميع الحقول واختيار صورة");
      return;
    }

    setState(() => isLoading = true);

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://test.hatlifood.com/api/playlists'),
    );

    request.fields.addAll({
      'category_id': int.parse(categoryIdController.text.trim()).toString(),
      'title': titleController.text.trim(),
      'description': descController.text.trim(),
    });

    request.files.add(
      await http.MultipartFile.fromPath('image', imageFile!.path),
    );

    try {
      var response = await request.send();
      final body = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        Get.snackbar('تم', 'تمت إضافة البلاي ليست بنجاح');
        titleController.clear();
        descController.clear();
        categoryIdController.clear();
        setState(() => imageFile = null);
      } else {
        final decoded = json.decode(body);
        Get.snackbar('فشل', decoded['message'] ?? 'حدث خطأ');
        if (decoded['errors'] != null) {
          decoded['errors'].forEach((key, val) {
            Get.snackbar('خطأ في $key', val[0]);
          });
        }
      }
    } catch (e) {
      Get.snackbar('خطأ', 'فشل الاتصال بالخادم');
    } finally {
      setState(() => isLoading = false);
    }
  }

  int? selectedCategoryId;
  String selectedCategoryName = 'اختر القسم';

  @override
  void initState() {
    fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة Playlist'),
        backgroundColor: const Color(0xFF540B0E),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'عنوان البلاي ليست',
                ),
                validator: (value) => value!.isEmpty ? 'أدخل العنوان' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'الوصف'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'أدخل الوصف' : null,
              ),
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

              const SizedBox(height: 20),
              Text(
                'الصورة المختارة:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (imageFile != null)
                Image.file(
                  imageFile!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('اختيار صورة من المعرض'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF540B0E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                      isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            'حفظ',
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

  void _showCategoryBottomSheet(BuildContext context) async {
    try {
      List<CategoryModel> categories = await fetchCategories();
      List<CategoryModel> filteredList = [...categories];
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
                                        (cat) => cat.name
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
                                title: Text(category.name),
                                onTap: () {
                                  setState(() {
                                    categoryIdController.text =
                                        category.id.toString();
                                    selectedCategoryId = category.id;
                                    selectedCategoryName = category.name;
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
