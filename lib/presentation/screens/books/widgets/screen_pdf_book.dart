import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ScreenPdfBook extends StatelessWidget {
  final String url;

  const ScreenPdfBook({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("view_book".tr, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF540B0E),
      ),
      body: SfPdfViewer.network(
        url,
        canShowScrollHead: false,
        canShowScrollStatus: false,
        canShowPaginationDialog: false,
        enableDocumentLinkAnnotation: false,
      ),
    );
  }
}
