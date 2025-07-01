import 'package:learncosmetic/data/models/playlist_model.dart';
import 'package:learncosmetic/domain/repositories/playlist/playlist_repository_impl.dart';

class PlaylistUsecase {
  final PlaylistRepositoryImpl repository;

  PlaylistUsecase(this.repository);

  Future<List<Playlist>?> call() {
    return repository.getPlaylist();
  }

  Future<List<Playlist>?> getbyId() {
    return repository.getPlaylist();
  }
}
