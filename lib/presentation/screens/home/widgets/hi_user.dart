import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class HiUser extends StatelessWidget {
  const HiUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
        left: 16.0,
        top: 8,
        right: 16.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "أهلاً بكِ، سعاد!",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "استكشفي أحدث الدورات في عالم التجميل",
              style: TextStyle(
                color: const Color.fromARGB(255, 65, 16, 20),
                fontSize: 16,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
