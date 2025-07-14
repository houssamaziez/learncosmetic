import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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

  Widget _buildFileTile(
    String label,
    File? file,
    VoidCallback onTap,
    IconData icon,
  ) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Colors.grey.shade200,
      leading: Icon(icon, color: Colors.brown),
      title: Text(file == null ? "اختر $label" : "تم اختيار $label"),
      trailing: const Icon(Icons.upload_file),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة كتاب", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF540B0E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'عنوان الكتاب'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'هذا الحقل مطلوب'
                            : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'وصف الكتاب'),
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
              const SizedBox(height: 10),
              _buildFileTile(
                "صورة الغلاف",
                selectedImage,
                () => pickFile(isPdf: false),
                Icons.image,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: isLoading ? null : uploadBook,
                icon: const Icon(Icons.cloud_upload),
                label:
                    isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("رفع الكتاب"),
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
}
