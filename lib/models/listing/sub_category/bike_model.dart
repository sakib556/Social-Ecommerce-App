
import 'package:protibeshi_app/models/listing/category/product_model.dart';

class BikeModel extends ProductModel {
  String brand;
  String model;

  BikeModel({
    required String id,
    required String title,
    required String userId,
    required String categoryId,
    required String subCategoryId,
    required String details,
    required List<String> imageUrl,
    required String condition,
    required DateTime creationTime,
    required bool available,
    required dynamic locationCode,
    required String locationName,
    required bool forRent,
    required bool forSell,
     double distance=0,
    required this.brand,
    required this.model,
    String? costFirstDay,
    String? originalPrice,
    String? sellPrice,
    String? costPerExtraDay,
    String? costPerHour,
  })
      : super(
            id: id,
            title: title,
            userId: userId,
            categoryId: categoryId,
            subCategoryId: subCategoryId,
            details: details,
            imageUrl: imageUrl,
            condition: condition,
            creationTime: creationTime,
            available: available,
            locationCode: locationCode,
            locationName: locationName,
            distance: distance,
            forRent: forRent,
            forSell: forSell,
            costFirstDay: costFirstDay ?? "",
            originalPrice: originalPrice ?? "",
            sellPrice: sellPrice ?? "",
            costPerExtraDay: costPerExtraDay ?? "",
            costPerHour: costPerHour ?? "",
            
            );


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryId': categoryId,
      'subCategoryId': subCategoryId,
      'title': title,
      'brand': brand,
      'model': model,
      'condition': condition,
      'originalPrice': originalPrice,
      'costFirstDay': costFirstDay,
      'costPerExtraDay': costPerExtraDay,
      'costPerHour': costPerHour,
      'sellPrice': sellPrice,
      'forRent': forRent,
      'forSell': forSell,
      'userId': userId,
      'details': details,
      'imageUrl': imageUrl,
      'creationTime': creationTime.millisecondsSinceEpoch,
      'available': available,
      'locationCode': locationCode,
      'locationName': locationName,
    };
  }

  factory BikeModel.fromMap(Map<String, dynamic> map) {
    return BikeModel(
      id: map['id'] ,
      categoryId: map['categoryId'] ,
      subCategoryId: map['subCategoryId'] ,
      title: map['title'],
      brand: map['brand'] ,
      model: map['model'] ,
      condition: map['condition'],
      originalPrice : map['originalPrice']  ?? "" ,
      costFirstDay : map['costFirstDay'] ?? "" ,
      costPerExtraDay: map['costPerExtraDay'] ?? "" ,
      costPerHour: map['costPerHour'] ?? "",
      sellPrice: map['sellPrice'] ?? "",
      forRent: map['forRent'] ,
      forSell: map['forSell'] ,
      userId: map['userId'] ,
      details: map['details'] ,
      imageUrl: List<String>.from((map['imageUrl'])),
      creationTime: DateTime.fromMillisecondsSinceEpoch(map['creationTime']),
      available: map['available'] ,
      locationCode: map['locationCode'],
      locationName: map['locationName']
    );
  }


}
