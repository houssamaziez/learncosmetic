import 'package:get/get.dart';
import 'package:learncosmetic/core/constants/api_constants.dart';
import 'package:learncosmetic/core/constants/api_headers.dart';
import 'package:learncosmetic/core/network/http_error_handler.dart';

import 'package:http/http.dart' as http;
import 'package:learncosmetic/data/models/commenter.dart';
import 'package:learncosmetic/data/models/episode_model.dart';
import 'package:learncosmetic/domain/repositories/episode/episode_repository.dart';
import 'dart:convert';

import '../../../data/models/category_model.dart';
import '../../../presentation/controllers/login_controller.dart';
import '../user/user_repository.dart';

class EpisodeRepositoryImpl implements EpisodeRepository {
  final http.Client client;

  EpisodeRepositoryImpl({required this.client});

  @override
  Future<List<Episode>?> getEpisode(int idPlaylist) async {
    final response = await client.get(
      Uri.parse(ApiConstants.episodePlaylist + idPlaylist.toString()),
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

  @override
  Future<List<Commenter>?> getEpisodeCommenter(int idEpisode) async {
    final response = await client.get(
      Uri.parse(ApiConstants.episode + idEpisode.toString() + '/comments'),
      headers: ApiHeaders.json,
    );
    if (response.statusCode == 200) {
      var varmapdata = json.decode(response.body)['data'];
      var data =
          (varmapdata as List)
              .map((promotion) => Commenter.fromJson(promotion))
              .toList();
      return data;
    } else {
      HttpErrorHandler.handle(response.statusCode, response.body);
    }
    return [];
  }

  @override
  Future<void> addEpisodeCommenter(int idEpisode, String content) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.episode + 'comment'),
        headers: ApiHeaders.json,
        body: json.encode({
          "user_id": Get.find<AuthController>().user!.id,
          "course_id": idEpisode,
          "content": content,
        }),
      );
      if (response.statusCode == 200) {
      } else {
        HttpErrorHandler.handle(response.statusCode, response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool?> addEpisodeLike(int idEpisode) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.episode + 'like'),
        headers: ApiHeaders.json,
        body: json.encode({
          "user_id": Get.find<AuthController>().user!.id,
          "course_id": idEpisode,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body)['is_liked'] as bool;
      } else {
        HttpErrorHandler.handle(response.statusCode, response.body);
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Episode>?> getAllEpisode() async {
    final response = await client.get(
      Uri.parse(ApiConstants.episode),
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
}
