abstract class PromotionRepository {
  Future<PromotionRepository?> getPromotions();

  Future<void> addPromotion();

  Future<void> deletePromotion();

  Future<void> updatePromotion() async {}
  Future<void> getPromotionById(String id);
}
