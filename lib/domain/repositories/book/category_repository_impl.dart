import 'package:learncosmetic/core/constants/api_constants.dart';
import 'package:learncosmetic/core/constants/api_headers.dart';
import 'package:learncosmetic/core/network/http_error_handler.dart';
import 'package:learncosmetic/data/models/book.dart';
import 'package:learncosmetic/domain/repositories/book/book_repository.dart';
import 'package:learncosmetic/domain/repositories/category/category_repository.dart'
    show CategoryRepository;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/models/category_model.dart';

class BookRepositoryImpl implements BookRepository {
  final http.Client client;

  BookRepositoryImpl({required this.client});

  @override
  Future<List<Book>?> getBooks() async {
    final response = await client.get(
      Uri.parse(ApiConstants.book),
      headers: ApiHeaders.json,
    );
    if (response.statusCode == 200) {
      try {
        var data =
            (json.decode(response.body)['data'] as List)
                .map((promotion) => Book.fromJson(promotion))
                .toList();
        return data;
      } catch (e) {
        print(e);
      }
    } else {
      HttpErrorHandler.handle(response.statusCode, response.body);
    }
    return [];
  }

  @override
  Future<void> addPromotion() {
    // TODO: implement addPromotion
    throw UnimplementedError();
  }

  @override
  Future<void> deletePromotion() {
    // TODO: implement deletePromotion
    throw UnimplementedError();
  }

  @override
  Future<void> getPromotionById(String id) {
    // TODO: implement getPromotionById
    throw UnimplementedError();
  }

  @override
  Future<void> updatePromotion() {
    // TODO: implement updatePromotion
    throw UnimplementedError();
  }
}
