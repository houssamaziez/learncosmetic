import 'package:learncosmetic/data/models/promotion_banner.dart';
import 'package:learncosmetic/domain/repositories/promotion/promotion_repository.dart';
import 'package:learncosmetic/domain/repositories/promotion/promotion_repository_impl.dart';

class PromotionUsecase {
  final PromotionRepositoryImpl repository;

  PromotionUsecase(this.repository);

  Future<PromotionBanner?> call() {
    return repository.getPromotions();
  }
}
