import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learncosmetic/data/models/book.dart';
import 'package:learncosmetic/presentation/screens/books/widgets/screen_pdf_book.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_size.dart';
import '../../controllers/book_controller.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookController>();
    controller.getBooks();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الكتب التعليمية',
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary.withOpacity(0.1),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.books.isEmpty) {
          return const Center(child: Text('لا توجد كتب متاحة حالياً'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppSize.spacingM),
          itemCount: controller.books.length,
          itemBuilder: (context, index) {
            final book = controller.books[index];
            return bookCard(book);
          },
        );
      }),
    );
  }

  Widget bookCard(Book book) {
    return InkWell(
      onTap: () {
        Get.to(ScreenPdfBook(url: book.pdfUrl));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSize.spacingM),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.radiusM),
          boxShadow: [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSize.radiusM),
                bottomLeft: Radius.circular(AppSize.radiusM),
              ),
              child: Image.network(
                book.imageUrl,
                width: 100,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),

            // Book Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSize.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: AppSize.fontSizeL,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF540B0E),
                      ),
                    ),
                    const SizedBox(height: AppSize.spacingXS),
                    Text(
                      book.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: AppSize.fontSizeS,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: AppSize.spacingS),
                    Row(
                      children: const [
                        Icon(Icons.picture_as_pdf, color: Colors.red, size: 20),
                        SizedBox(width: 6),
                        Text(
                          'عرض PDF',
                          style: TextStyle(
                            fontSize: AppSize.fontSizeS,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
