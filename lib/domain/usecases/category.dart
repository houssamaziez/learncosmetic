import '../../data/models/category_model.dart';
import '../repositories/category/category_repository_impl.dart';

class CategoryUsecase {
  final CategoryRepositoryImpl repository;

  CategoryUsecase(this.repository);

  Future<List<CategoryModel>?> call() {
    return repository.getCategorys();
  }
}
