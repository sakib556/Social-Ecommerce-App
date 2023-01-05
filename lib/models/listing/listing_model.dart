
class ListingModel {
  String listingId;
  String categoryId;
  String subCategoryId;
  bool forRent;
  ListingModel({
    required this.listingId,
    required this.categoryId,
    required this.subCategoryId,
    required this.forRent,
  });
}
// class ListingModel {
//   String listingId;
//   BookModel? bookModel;
//   BikeModel? bikeModel;
//   HomeMadeFoodModel? homeMadeFoodModel;
//   ServiceModel? serviceModel;
//   TeachingModel? teachingModel;
//   ListingModel({
//     required this.listingId,
//     this.bookModel,
//     this.bikeModel,
//     this.homeMadeFoodModel,
//     this.serviceModel,
//     this.teachingModel,
//   });
// }
