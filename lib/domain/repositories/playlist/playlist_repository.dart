import 'package:learncosmetic/data/models/playlist_model.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/promotion_banner.dart';

abstract class PlaylistRepository {
  Future<List<Playlist>?> getPlaylist();

  Future<void> addPromotion();

  Future<void> deletePromotion();

  Future<void> updatePromotion() async {}
  Future<void> getPromotionById(String id);
}
