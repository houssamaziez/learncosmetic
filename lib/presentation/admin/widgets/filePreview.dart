import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget filePreview(File? file, IconData icon, String label) {
  return file != null
      ? Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              file.path.split('/').last,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      )
      : Text(label, style: TextStyle(color: Colors.grey));
}
