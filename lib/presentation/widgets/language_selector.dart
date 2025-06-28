import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_size.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const langs = [
      {'label': 'العربية', 'locale': Locale('ar')},
      {'label': 'English', 'locale': Locale('en')},
      {'label': 'Français', 'locale': Locale('fr')},
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.paddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            langs.map((lang) {
              final isSelected = Get.locale == lang['locale'];
              return GestureDetector(
                onTap: () {
                  Get.updateLocale(lang['locale'] as Locale);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.paddingS,
                  ),
                  child: Text(
                    lang['label'] as String,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey,
                      decoration: isSelected ? TextDecoration.underline : null,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
