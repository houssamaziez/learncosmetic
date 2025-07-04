import '../../data/models/search_result_model.dart';
import '../repositories/search/search_repository_impl.dart';

class SearchUsecase {
  final SearchRepositoryImpl repository;
  SearchUsecase(this.repository);
  Future<SearchResultModel?> call(String keyword) {
    return repository.search(keyword);
  }
}
