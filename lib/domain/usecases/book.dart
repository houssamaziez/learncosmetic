import 'package:learncosmetic/data/models/book.dart';
import 'package:learncosmetic/domain/repositories/book/category_repository_impl.dart';

class BookUsecase {
  final BookRepositoryImpl repository;

  BookUsecase(this.repository);

  Future<List<Book>?> call() {
    return repository.getBooks();
  }
}
