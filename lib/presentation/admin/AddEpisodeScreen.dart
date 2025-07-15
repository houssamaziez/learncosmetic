import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:learncosmetic/presentation/admin/widgets/buildUploadProgressBar.dart';
import 'package:learncosmetic/presentation/admin/widgets/filePreview.dart';
import 'package:path/path.dart' as path;
import '../../data/models/playlist_model.dart';
import 'widgets/uploadEpisodeWithProgress.dart' show uploadEpisodeWithProgress;

class AddEpisodeScreen extends StatefulWidget {
  const AddEpisodeScreen({Key? key}) : super(key: key);

  @override
  State<AddEpisodeScreen> createState() => _AddEpisodeScreenState();
}

class _AddEpisodeScreenState extends State<AddEpisodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  File? selectedImage;
  File? selectedVideo;
  bool isLoading = false;

  TextEditingController categoryIdController = TextEditingController();

  int? selectedPlaylistId;
  int? selectedCategoryId;
  String selectedCategoryName = 'اختر القسم';
  double uploadProgress = 0.0;
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

  Future<void> pickFile(bool isImage) async {
    final picker = ImagePicker();
    final picked =
        isImage
            ? await picker.pickImage(source: ImageSource.gallery)
            : await picker.pickVideo(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        if (isImage) {
          selectedImage = File(picked.path);
        } else {
          selectedVideo = File(picked.path);
        }
      });
    }
  }

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
          'إضافة حلقة جديدة',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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

              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'عنوان الحلقة',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'العنوان مطلوب' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'الوصف',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (v) => v!.isEmpty ? 'الوصف مطلوب' : null,
              ),
              const SizedBox(height: 20),

              /// Pick Image
              TextButton.icon(
                onPressed: () => pickFile(true),
                icon: const Icon(Icons.image),
                label: const Text("اختيار صورة"),
              ),
              filePreview(selectedImage, Icons.image, "لم يتم اختيار صورة"),

              const SizedBox(height: 12),

              /// Pick Video
              TextButton.icon(
                onPressed: () => pickFile(false),
                icon: const Icon(Icons.video_library),
                label: const Text("اختيار فيديو"),
              ),
              filePreview(
                selectedVideo,
                Icons.video_file,
                "لم يتم اختيار فيديو",
              ),

              const SizedBox(height: 24),
              Visibility(
                visible: uploadProgress > 0 && uploadProgress < 1,
                child: buildUploadProgressBar(uploadProgress),
              ),

              /// Submit Button
              Visibility(
                visible: !(uploadProgress > 0 && uploadProgress < 1),
                child: ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : () {
                            uploadEpisodeWithProgress(
                              imageFile: selectedImage!,
                              videoFile: selectedVideo!,
                              title: titleController.text,
                              description: descriptionController.text,
                              playlistId: int.parse(categoryIdController.text),
                              onProgress: (progress) {
                                setState(() {
                                  uploadProgress = progress;

                                  print('Upload progress: $progress');
                                });
                              },
                            );
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child:
                      isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            "نشر الحلقة",
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
