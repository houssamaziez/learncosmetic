import 'package:learncosmetic/data/models/book.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/promotion_banner.dart';

abstract class BookRepository {
  Future<List<Book>?> getBooks();
}
