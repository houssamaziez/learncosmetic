import '../../../data/models/search_result_model.dart';

abstract class SearchRepository {
  Future<SearchResultModel?> search(String keyword);
}
