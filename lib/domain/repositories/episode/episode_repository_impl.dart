import 'package:learncosmetic/core/constants/api_constants.dart';
import 'package:learncosmetic/core/constants/api_headers.dart';
import 'package:learncosmetic/core/network/http_error_handler.dart';

import 'package:http/http.dart' as http;
import 'package:learncosmetic/data/models/episode_model.dart';
import 'package:learncosmetic/domain/repositories/episode/episode_repository.dart';
import 'dart:convert';

import '../../../data/models/category_model.dart';

class EpisodeRepositoryImpl implements EpisodeRepository {
  final http.Client client;

  EpisodeRepositoryImpl({required this.client});

  @override
  Future<List<Episode>?> getEpisode(int idPlaylist) async {
    final response = await client.get(
      Uri.parse(ApiConstants.episode + idPlaylist.toString()),
      headers: ApiHeaders.json,
    );
    if (response.statusCode == 200) {
      var varmapdata = json.decode(response.body)['data'];
      var data =
          (varmapdata as List)
              .map((promotion) => Episode.fromJson(promotion))
              .toList();
      return data;
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
