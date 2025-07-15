import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/models/user_model.dart';
import '../controller/adminecontroller.dart';

class AllUsersScreen extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());

  AllUsersScreen({super.key});

  String formatDate(String? date) {
    if (date == null) return "غير متوفر";
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchUsers();

    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة المستخدمين'),
        backgroundColor: const Color(0xFF540B0E),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.users.isEmpty) {
          return const Center(child: Text('لا يوجد مستخدمين'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final user = controller.users[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Image
                    CircleAvatar(
                      radius: 35,
                      backgroundImage:
                          user.imageUser != null
                              ? NetworkImage('${user.imageUser}')
                              : null,
                      child:
                          user.imageUser == null
                              ? const Icon(Icons.person, size: 35)
                              : null,
                    ),
                    const SizedBox(width: 16),

                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 4),
                          Text("📞 ${user.phone ?? 'غير متوفر'}"),
                          Text("📍 ${user.address ?? 'غير متوفر'}"),
                          const SizedBox(height: 4),
                          Text(
                            "📅 أنشئ في: ${formatDate(user.createdAt.toString())}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ✅ نص الصلاحية
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "⏳ صلاحية: ${formatDate(user.expirydate)}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // ✅ شارة حالة الصلاحية
                                  Chip(
                                    label: Text(
                                      DateTime.tryParse(
                                                user.expirydate.toString(),
                                              )?.isAfter(DateTime.now()) ==
                                              true
                                          ? "مفعّل ✅"
                                          : "انتهت الصلاحية ❌",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor:
                                        DateTime.tryParse(
                                                  user.expirydate.toString(),
                                                )?.isAfter(DateTime.now()) ==
                                                true
                                            ? Colors.green
                                            : Colors.red,
                                  ),
                                ],
                              ),

                              // ✏️ زر تغيير التاريخ
                              IconButton(
                                icon: const Icon(
                                  Icons.edit_calendar_outlined,
                                  color: Colors.blueAccent,
                                ),
                                tooltip: "تعديل تاريخ الصلاحية",
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        DateTime.tryParse(
                                          user.expirydate.toString(),
                                        ) ??
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
                            ],
                          ),

                          const SizedBox(height: 4),
                          Row(
                            children: [
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
                                            confirmTextColor: Colors.white,
                                            buttonColor: Colors.red,
                                            onConfirm: () async {
                                              Navigator.pop(Get.context!);
                                              await controller
                                                  .removeUserDiveseId(
                                                    int.parse(user.id),
                                                  ); // تنفيذ الحذف
                                            },
                                          );
                                        }
                                        : null,
                                child: Chip(
                                  label: Text(
                                    user.device_id != null
                                        ? "لديه جهاز"
                                        : "ليس لديه جهاز",
                                    style: const TextStyle(color: Colors.white),
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

                    // Action
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.delete(int.parse(user.id), "users");
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
