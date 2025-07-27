import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learncosmetic/core/constants/app_colors.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  final storage = GetStorage();
  Locale? _selectedLocale;

  @override
  void initState() {
    super.initState();
    String? storedLang = storage.read('languageCode');
    String? storedCountry = storage.read('countryCode');
    if (storedLang != null && storedCountry != null) {
      _selectedLocale = Locale(storedLang, storedCountry);
    } else {
      _selectedLocale = Get.locale;
    }
  }

  void _changeLanguage() {
    if (_selectedLocale != null) {
      Get.updateLocale(_selectedLocale!);
      storage.write('languageCode', _selectedLocale!.languageCode);
      storage.write('countryCode', _selectedLocale!.countryCode);
      Get.back();
    }
  }

  Widget _buildLanguageTile({
    required String title,
    required String subtitle,
    required Locale locale,
  }) {
    bool isSelected = _selectedLocale?.languageCode == locale.languageCode;

    return GestureDetector(
      onTap: () => setState(() => _selectedLocale = locale),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primary.withAlpha(50)
                  : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRTL = _selectedLocale?.languageCode == 'ar';

    return Directionality(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text('change_language'.tr), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildLanguageTile(
                title: 'العربية',
                subtitle: 'Arabic',
                locale: const Locale('ar', 'DZ'),
              ),
              _buildLanguageTile(
                title: 'English',
                subtitle: 'English',
                locale: const Locale('en', 'US'),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: Text('save'.tr),
                  onPressed: _changeLanguage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
