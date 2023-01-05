import 'package:protibeshi_app/models/listing/parent_category_model.dart';

class ProductModel extends ParentCategoryModel {
  String condition;
  String title;
  String details;
  List<String> imageUrl;
  ProductModel(
      {required String id,
      required String categoryId,
      required String subCategoryId,
      required String userId,
      
    required this.title,
    required this.details,
    required this.imageUrl,
      required DateTime creationTime,
      required bool available,
      required locationCode,
      required String locationName,
      required double distance,
      required bool forRent,
      required bool forSell,
      required String costFirstDay,
      required String originalPrice,
      required String sellPrice,
      required String costPerExtraDay,
      required String costPerHour,
      required this.condition})
      : super(
            id: id,
            categoryId: categoryId,
            subCategoryId: subCategoryId,
            userId: userId,
            creationTime: creationTime,
            available: available,
            locationCode: locationCode,
            locationName: locationName,
            distance: distance,
            forRent: forRent,
            forSell: forSell,
            costFirstDay: costFirstDay,
            originalPrice: originalPrice,
            sellPrice: sellPrice,
            costPerExtraDay: costPerExtraDay,
            costPerHour: costPerHour);
}
