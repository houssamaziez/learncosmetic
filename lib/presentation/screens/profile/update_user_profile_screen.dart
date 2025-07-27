import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_size.dart';
import '../../../data/models/user_model.dart';
import '../../controllers/login_controller.dart';
import '../../widgets/spinkit.dart';

class UpdateUserProfileScreen extends StatefulWidget {
  final UserModel user;

  const UpdateUserProfileScreen({Key? key, required this.user})
    : super(key: key);

  @override
  State<UpdateUserProfileScreen> createState() =>
      _UpdateUserProfileScreenState();
}

class _UpdateUserProfileScreenState extends State<UpdateUserProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    phoneController = TextEditingController(text: widget.user.phone ?? '');
    addressController = TextEditingController(text: widget.user.address ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void updateProfile() {
    if (_formKey.currentState!.validate()) {
      authController.updateProfile(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        imageuser: _selectedImage,
      );
      Get.back();
      Get.snackbar("done".tr, "update_success".tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "edit_profile".tr,
          style: TextStyle(color: AppColors.primary),
        ),
        backgroundColor: AppColors.primary.withOpacity(0.1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.paddingL),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage:
                          _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : (widget.user.imageUser != null
                                  ? NetworkImage(widget.user.imageUser!)
                                      as ImageProvider
                                  : null),
                      child:
                          _selectedImage == null &&
                                  widget.user.imageUser == null
                              ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              )
                              : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: InkWell(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSize.spacingL),

              _buildTextField("full_name".tr, nameController),
              const SizedBox(height: AppSize.spacingM),

              _buildTextField(
                "email".tr,
                emailController,
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSize.spacingM),

              _buildTextField(
                "phone_number".tr,
                phoneController,
                inputType: TextInputType.phone,
              ),
              const SizedBox(height: AppSize.spacingM),

              _buildTextField("title".tr, addressController),
              const SizedBox(height: AppSize.spacingL),

              SizedBox(
                width: double.infinity,
                height: AppSize.buttonHeight,
                child: ElevatedButton(
                  onPressed: updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF540B0E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.radiusS),
                    ),
                  ),
                  child: GetBuilder<AuthController>(
                    builder: (controller) {
                      return controller.isLoadingUpdate
                          ? spinkit
                          : Text(
                            "save_changes".tr,
                            style: TextStyle(color: Colors.white),
                          );
                    },
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
    TextInputType inputType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: AppSize.spacingXS),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "field_required".tr;
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.radiusS),
            ),
          ),
        ),
      ],
    );
  }
}
