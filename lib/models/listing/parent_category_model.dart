// ignore_for_file: public_member_api_docs, sort_constructors_first
class ParentCategoryModel {
  String id; //product,service,.....
  String categoryId; //product,service,.....
  String subCategoryId;  //book,car,cycle,.......
  String userId;

  DateTime creationTime;
  bool available;
  dynamic locationCode;
  String locationName;
  double distance;
  bool forRent;
  bool forSell;
  String costFirstDay;
  String originalPrice;
  String sellPrice;
  String costPerExtraDay;
  String costPerHour;
  ParentCategoryModel({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.userId,
    required this.creationTime,
    required this.available,
    required this.locationCode,
    required this.locationName,
    required this.distance,
    required this.forRent,
    required this.forSell,
    required this.costFirstDay,
    required this.originalPrice,
    required this.sellPrice,
    required this.costPerExtraDay,
    required this.costPerHour,
  });
}
