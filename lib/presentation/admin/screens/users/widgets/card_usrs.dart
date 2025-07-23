import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../data/models/user_model.dart';
import '../../../controller/adminecontroller.dart';

class CardUsrs extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());

  UserModel user;
  bool isActive;
  BuildContext context;
  DateTime? expiryDate;
  CardUsrs({
    required this.user,
    required this.isActive,
    required this.context,
    this.expiryDate,
  });

  Widget _infoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 18, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.blueGrey.shade600,
    );
  }

  @override
  Widget build(BuildContext context) {
    String formatDate(String? date) {
      if (date == null) return "غير متوفر";
      try {
        return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
      } catch (_) {
        return "غير صالح";
      }
    }

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage:
                      (user.imageUser != null && user.imageUser!.isNotEmpty)
                          ? NetworkImage(user.imageUser!)
                          : null,
                  child:
                      (user.imageUser == null || user.imageUser!.isEmpty)
                          ? const Icon(Icons.person, size: 30)
                          : null,
                ),

                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed:
                      () => controller
                          .delete(int.parse(user.id), "users")
                          .then((value) => controller.fetchUsers()),
                ),
              ],
            ),
            const Divider(height: 24),
            Wrap(
              runSpacing: 10,
              spacing: 12,
              children: [
                _infoChip(Icons.phone, user.phone ?? "غير متوفر"),
                _infoChip(Icons.home, user.address ?? "غير متوفر"),
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
                    isActive ? "مفعّل ✅" : "انتهت الصلاحية ❌",
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: isActive ? Colors.green : Colors.red,
                ),
                ActionChip(
                  avatar: const Icon(Icons.edit_calendar, size: 18),
                  label: const Text("تعديل الصلاحية"),
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: expiryDate ?? DateTime.now(),
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
                              middleText: "هل تريد حذف معرف الجهاز؟",
                              textCancel: "إلغاء",
                              textConfirm: "نعم، حذف",
                              confirmTextColor: Colors.white,
                              buttonColor: Colors.red,
                              onConfirm: () async {
                                Navigator.pop(Get.context!);
                                await controller.removeUserDiveseId(
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
                      user.device_id != null ? "لديه جهاز" : "ليس لديه جهاز",
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor:
                        user.device_id != null ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
