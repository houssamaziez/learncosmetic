import '../../../data/models/category_model.dart';
import '../../../data/models/promotion_banner.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>?> getCategorys();

  Future<void> addPromotion();

  Future<void> deletePromotion();

  Future<void> updatePromotion() async {}
  Future<void> getPromotionById(String id);
}
