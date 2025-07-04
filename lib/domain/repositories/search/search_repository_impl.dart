import 'dart:convert';

import 'package:learncosmetic/data/models/search_result_model.dart';
import 'package:learncosmetic/domain/repositories/search/search_repository.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/api_constants.dart';
import '../../../core/constants/api_headers.dart';

class SearchRepositoryImpl extends SearchRepository {
  final http.Client client;

  SearchRepositoryImpl({required this.client});
  @override
  Future<SearchResultModel?> search(String keyword) async {
    try {
      final response = await client.get(
        Uri.parse(
          ApiConstants.search,
        ).replace(queryParameters: ({'keyword': keyword})),
        headers: ApiHeaders.json,
      );
      if (response.statusCode == 200) {
        return SearchResultModel.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
