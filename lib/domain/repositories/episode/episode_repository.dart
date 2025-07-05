import 'package:learncosmetic/data/models/commenter.dart';
import 'package:learncosmetic/data/models/episode_model.dart';

abstract class EpisodeRepository {
  Future<List<Episode>?> getEpisode(int idPlaylist);
  Future<List<Commenter>?> getEpisodeCommenter(int idEpisode);
  Future<void> addEpisodeCommenter(int idEpisode, String content);

  Future<void> addPromotion();

  Future<void> deletePromotion();

  Future<void> updatePromotion() async {}
  Future<void> getPromotionById(String id);
}
