import '../../../data/models/promotion_banner.dart';

abstract class PromotionRepository {
  Future<PromotionBanner?> getPromotions();

  Future<void> addPromotion();

  Future<void> deletePromotion();

  Future<void> updatePromotion() async {}
  Future<void> getPromotionById(String id);
}
