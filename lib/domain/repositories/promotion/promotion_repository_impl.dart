import 'package:learncosmetic/core/constants/api_constants.dart';
import 'package:learncosmetic/core/constants/api_headers.dart';
import 'package:learncosmetic/core/network/http_error_handler.dart';
import 'package:learncosmetic/data/models/promotion_banner.dart';
import 'package:learncosmetic/domain/repositories/promotion/promotion_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PromotionRepositoryImpl implements PromotionRepository {
  final http.Client client;

  PromotionRepositoryImpl({required this.client});

  @override
  Future<PromotionBanner?> getPromotions() async {
    final response = await client.get(
      Uri.parse(ApiConstants.promotions),
      headers: ApiHeaders.json,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      HttpErrorHandler.handle(response.statusCode, response.body);
    }
    return null;
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
