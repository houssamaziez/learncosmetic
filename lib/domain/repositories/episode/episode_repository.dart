import 'package:learncosmetic/data/models/episode_model.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/promotion_banner.dart';

abstract class EpisodeRepository {
  Future<List<Episode>?> getEpisode(int idPlaylist);

  Future<void> addPromotion();

  Future<void> deletePromotion();

  Future<void> updatePromotion() async {}
  Future<void> getPromotionById(String id);
}
