import 'package:learncosmetic/data/models/promotion_banner.dart';
import 'package:learncosmetic/domain/repositories/promotion/promotion_repository.dart';

class PromotionUsecase {
  final PromotionRepository repository;

  PromotionUsecase(this.repository);

  Future<PromotionRepository?> call(String email, String password) {
    return repository.getPromotions();
  }
}
