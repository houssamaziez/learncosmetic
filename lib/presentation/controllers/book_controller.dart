import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/book.dart';
import '../../domain/usecases/book.dart';

class BookController extends GetxController {
  final BookUsecase bookUsecase;
  final books = <Book>[].obs;
  final RxBool isLoading = false.obs;

  BookController({required this.bookUsecase});

  Future<List<Book>?> getBooks() async {
    isLoading.value = true;
    try {
      // Simulate fetching promotions from a repository
      final List<Book>? result = await bookUsecase();
      books.value = result!;
      return result;
    } catch (e) {
      throw Exception('PromotionBanner not found');
    } finally {
      isLoading.value = false;
    }
  }
}
