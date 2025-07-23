import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learncosmetic/presentation/admin/screens/users/widgets/appbar.dart'
    show AppbarUsers;
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/user_model.dart';
import '../../../../routes/app_routes.dart';
import '../../controller/adminecontroller.dart';
import 'widgets/card_usrs.dart';

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
      appBar: AppbarUsers(),
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

                          return CardUsrs(
                            user: user,
                            isActive: isActive,
                            context: context,
                            expiryDate: expiryDate,
                          );
                        },
                      ),
            ),
          ],
        );
      }),
    );
  }
}
