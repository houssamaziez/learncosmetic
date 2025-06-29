import 'package:learncosmetic/core/constants/api_constants.dart';
import 'package:learncosmetic/core/constants/api_headers.dart';
import 'package:learncosmetic/core/network/http_error_handler.dart';
import 'package:learncosmetic/data/models/playlist_model.dart';
import 'package:learncosmetic/domain/repositories/category/category_repository.dart'
    show CategoryRepository;
import 'package:http/http.dart' as http;
import 'package:learncosmetic/domain/repositories/playlist/playlist_repository.dart';
import 'dart:convert';

import '../../../data/models/category_model.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  final http.Client client;

  PlaylistRepositoryImpl({required this.client});

  @override
  Future<List<Playlist>?> getPlaylist() async {
    final response = await client.get(
      Uri.parse(ApiConstants.playlists),
      headers: ApiHeaders.json,
    );
    if (response.statusCode == 200) {
      var data =
          (json.decode(response.body)['data'] as List)
              .map((playlist) => Playlist.fromJson(playlist))
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
