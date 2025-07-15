import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/user_model.dart';
import '../../../routes/app_routes.dart';
import '../controller/adminecontroller.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final AdminController controller = Get.put(AdminController());

  String searchQuery = '';
  bool showActiveOnly = false;
  bool showExpiredOnly = false;
  bool showHasDeviceOnly = false;
  bool showNoDeviceOnly = false;

  @override
  void initState() {
    super.initState();
    controller.fetchUsers();
  }

  String formatDate(String? date) {
    if (date == null) return "غير متوفر";
    try {
      return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
    } catch (_) {
      return "غير صالح";
    }
  }

  bool matchesFilters(UserModel user) {
    final expiry = DateTime.tryParse(user.expirydate ?? '');
    final isActive = expiry != null && expiry.isAfter(DateTime.now());
    final hasDevice = user.device_id != null;

    if (showActiveOnly && !isActive) return false;
    if (showExpiredOnly && isActive) return false;
    if (showHasDeviceOnly && !hasDevice) return false;
    if (showNoDeviceOnly && hasDevice) return false;

    if (searchQuery.isNotEmpty &&
        !user.name.toLowerCase().contains(searchQuery.toLowerCase())) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة المستخدمين'),
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.05),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.addUser);
            },
            icon: Icon(Icons.add),
            color: Colors.black,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final filteredUsers = controller.users.where(matchesFilters).toList();

        return Column(
          children: [
            // 🔍 Search Field
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'بحث بالاسم...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) => setState(() => searchQuery = value),
              ),
            ),

            // 🔽 Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('مفعّل ✅'),
                    selected: showActiveOnly,
                    onSelected:
                        (value) => setState(() {
                          showActiveOnly = value;
                          if (value) showExpiredOnly = false;
                        }),
                    selectedColor: Colors.green.shade100,
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('منتهي ❌'),
                    selected: showExpiredOnly,
                    onSelected:
                        (value) => setState(() {
                          showExpiredOnly = value;
                          if (value) showActiveOnly = false;
                        }),
                    selectedColor: Colors.red.shade100,
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('لديه جهاز'),
                    selected: showHasDeviceOnly,
                    onSelected:
                        (value) => setState(() {
                          showHasDeviceOnly = value;
                          if (value) showNoDeviceOnly = false;
                        }),
                    selectedColor: Colors.blue.shade100,
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('ليس لديه'),
                    selected: showNoDeviceOnly,
                    onSelected:
                        (value) => setState(() {
                          showNoDeviceOnly = value;
                          if (value) showHasDeviceOnly = false;
                        }),
                    selectedColor: Colors.orange.shade100,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 📄 Users List
            Expanded(
              child:
                  filteredUsers.isEmpty
                      ? const Center(
                        child: Text("لا يوجد مستخدمين بالمواصفات المحددة"),
                      )
                      : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          final user = filteredUsers[index];
                          final expiryDate = DateTime.tryParse(
                            user.expirydate ?? '',
                          );
                          final isActive =
                              expiryDate != null &&
                              expiryDate.isAfter(DateTime.now());

                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.04),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundImage:
                                            (user.imageUser != null &&
                                                    user.imageUser!.isNotEmpty)
                                                ? NetworkImage(user.imageUser!)
                                                : null,
                                        child:
                                            (user.imageUser == null ||
                                                    user.imageUser!.isEmpty)
                                                ? const Icon(
                                                  Icons.person,
                                                  size: 30,
                                                )
                                                : null,
                                      ),

                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user.name,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              user.email,
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ),
                                        onPressed:
                                            () => controller
                                                .delete(
                                                  int.parse(user.id),
                                                  "users",
                                                )
                                                .then(
                                                  (value) =>
                                                      controller.fetchUsers(),
                                                ),
                                      ),
                                    ],
                                  ),
                                  const Divider(height: 24),
                                  Wrap(
                                    runSpacing: 10,
                                    spacing: 12,
                                    children: [
                                      _infoChip(
                                        Icons.phone,
                                        user.phone ?? "غير متوفر",
                                      ),
                                      _infoChip(
                                        Icons.home,
                                        user.address ?? "غير متوفر",
                                      ),
                                      _infoChip(
                                        Icons.calendar_today,
                                        "أنشئ في: ${formatDate(user.createdAt)}",
                                      ),
                                      _infoChip(
                                        Icons.lock_clock,
                                        "الصلاحية: ${formatDate(user.expirydate)}",
                                      ),
                                      Chip(
                                        label: Text(
                                          isActive
                                              ? "مفعّل ✅"
                                              : "انتهت الصلاحية ❌",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        backgroundColor:
                                            isActive
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                      ActionChip(
                                        avatar: const Icon(
                                          Icons.edit_calendar,
                                          size: 18,
                                        ),
                                        label: const Text("تعديل الصلاحية"),
                                        onPressed: () async {
                                          final selectedDate =
                                              await showDatePicker(
                                                context: context,
                                                initialDate:
                                                    expiryDate ??
                                                    DateTime.now(),
                                                firstDate: DateTime(2023),
                                                lastDate: DateTime(2030),
                                              );
                                          if (selectedDate != null) {
                                            controller.updateUserExpiryDate(
                                              int.parse(user.id),
                                              selectedDate,
                                            );
                                          }
                                        },
                                      ),
                                      InkWell(
                                        onTap:
                                            user.device_id != null
                                                ? () {
                                                  Get.defaultDialog(
                                                    title: "حذف الجهاز",
                                                    middleText:
                                                        "هل تريد حذف معرف الجهاز؟",
                                                    textCancel: "إلغاء",
                                                    textConfirm: "نعم، حذف",
                                                    confirmTextColor:
                                                        Colors.white,
                                                    buttonColor: Colors.red,
                                                    onConfirm: () async {
                                                      Navigator.pop(
                                                        Get.context!,
                                                      );
                                                      await controller
                                                          .removeUserDiveseId(
                                                            int.parse(user.id),
                                                          );
                                                    },
                                                  );
                                                }
                                                : null,
                                        child: Chip(
                                          avatar: const Icon(
                                            Icons.devices,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          label: Text(
                                            user.device_id != null
                                                ? "لديه جهاز"
                                                : "ليس لديه جهاز",
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor:
                                              user.device_id != null
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        );
      }),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 18, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.blueGrey.shade600,
    );
  }
}
