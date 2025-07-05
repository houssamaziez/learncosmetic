import 'package:learncosmetic/data/models/commenter.dart';
import 'package:learncosmetic/data/models/episode_model.dart';
import 'package:learncosmetic/domain/repositories/episode/episode_repository_impl.dart';

import '../../data/models/category_model.dart';
import '../repositories/category/category_repository_impl.dart';

class EpisodeUsecase {
  final EpisodeRepositoryImpl repository;

  EpisodeUsecase(this.repository);

  Future<List<Episode>?> call(int id) {
    return repository.getEpisode(
      id,
    ); // Replace 'someOtherArgument' with the actual argument needed.
  }

  Future<List<Commenter>?> getCommenter(int id) {
    return repository.getEpisodeCommenter(
      id,
    ); // Replace 'someOtherArgument' with the actual argument needed.
  }

  Future<void> addCommenter(int id, String content) {
    return repository.addEpisodeCommenter(
      id,
      content,
    ); // Replace 'someOtherArgument' with the actual argument needed.
  }
}
