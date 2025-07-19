import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learncosmetic/core/constants/app_colors.dart';
import 'package:learncosmetic/presentation/controllers/book_controller.dart'
    show BookController;

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  File? selectedPdf;
  File? selectedImage;
  bool isLoading = false;

  Future<void> pickFile({required bool isPdf}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: isPdf ? FileType.custom : FileType.image,
      allowedExtensions: isPdf ? ['pdf'] : null,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        if (isPdf) {
          selectedPdf = File(result.files.single.path!);
        } else {
          selectedImage = File(result.files.single.path!);
        }
      });
    }
  }

  Future<void> uploadBook() async {
    final controller = Get.find<BookController>();

    if (!_formKey.currentState!.validate() ||
        selectedPdf == null ||
        selectedImage == null) {
      Get.snackbar(
        "تنبيه",
        "يرجى تعبئة كل الحقول واختيار الملفات",
        backgroundColor: Colors.amber,
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://test.hatlifood.com/api/books'),
      );

      request.fields.addAll({
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
      });

      request.files.add(
        await http.MultipartFile.fromPath('pdf', selectedPdf!.path),
      );
      request.files.add(
        await http.MultipartFile.fromPath('image', selectedImage!.path),
      );

      http.StreamedResponse response = await request.send();
      final resBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "نجاح",
          "تم رفع الكتاب بنجاح",
          backgroundColor: Colors.green,
        );
        titleController.clear();
        descriptionController.clear();
        setState(() {
          selectedPdf = null;
          selectedImage = null;
        });
        controller.getBooks();
      } else {
        Get.snackbar("فشل", resBody, backgroundColor: Colors.red);
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

  Widget _buildImagePickerTile({
    required File? imageFile,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
          color: Colors.grey.shade100,
        ),
        child:
            imageFile == null
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.image_outlined, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        "اضغط لاختيار صورة الغلاف",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
                : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
      ),
    );
  }

  Widget _buildFileTile(
    String label,
    File? file,
    VoidCallback onTap,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: file != null ? Colors.green.shade100 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: file != null ? Colors.green : Colors.grey.shade400,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: AppColors.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                file == null ? "اضغط لاختيار $label" : "تم اختيار $label بنجاح",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Icon(Icons.upload_file, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة كتاب"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'عنوان الكتاب',
                  prefixIcon: const Icon(Icons.title),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'هذا الحقل مطلوب'
                            : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'وصف الكتاب',
                  prefixIcon: const Icon(Icons.description),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'هذا الحقل مطلوب'
                            : null,
              ),
              const SizedBox(height: 20),
              _buildFileTile(
                "ملف PDF",
                selectedPdf,
                () => pickFile(isPdf: true),
                Icons.picture_as_pdf,
              ),
              const SizedBox(height: 20),

              _buildImagePickerTile(
                imageFile: selectedImage,
                onTap: () => pickFile(isPdf: false),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : uploadBook,
                  icon: const Icon(
                    Icons.cloud_upload_rounded,
                    color: Colors.white,
                  ),
                  label:
                      isLoading
                          ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : const Text(
                            "رفع الكتاب",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
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
