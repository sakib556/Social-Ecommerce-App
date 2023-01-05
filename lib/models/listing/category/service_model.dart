
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:protibeshi_app/models/listing/parent_category_model.dart';

class ServiceModel extends ParentCategoryModel {
  ServiceInformationModel serviceInformation;
  
  ServiceModel(
      {required String id,
      required String categoryId,
      required String subCategoryId,
      required String userId,
      required DateTime creationTime,
      required bool available,
      required locationCode,
      required String locationName,
      double distance = 0,
      required bool forRent,
      required bool forSell,
      required String? costFirstDay,
      required String? originalPrice,
      required String? sellPrice,
      required String? costPerExtraDay,
      required String? costPerHour,
      required this.serviceInformation})
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
            costFirstDay: costFirstDay ?? "",
            originalPrice: originalPrice ?? "",
            sellPrice: sellPrice ?? "",
            costPerExtraDay: costPerExtraDay ?? "",
            costPerHour: costPerHour ?? "");

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceInformation': serviceInformation.toMap(),
      'id': id,
      'categoryId': categoryId,
      'subCategoryId': subCategoryId,
      'costFirstDay': costFirstDay,
      'originalPrice': originalPrice,
      'costPerExtraDay': costPerExtraDay,
      'costPerHour': costPerHour,
      'sellPrice': sellPrice,
      'forSell': forSell,
      'forRent': forRent,
      'userId': userId,
      'creationTime': creationTime.millisecondsSinceEpoch,
      'available': available,
      'locationCode': locationCode,
      'locationName': locationName,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      serviceInformation : ServiceInformationModel.fromMap(map['serviceInformation']),
      id: map['id'],
      categoryId: map['categoryId'],
      subCategoryId: map['subCategoryId'],
      costFirstDay: map['costFirstDay'],
      originalPrice: map['originalPrice'],
      costPerExtraDay: map['costPerExtraDay'] ?? "",
      costPerHour: map['costPerHour'] ?? "",
      sellPrice: map['sellPrice'] ?? "",
      forSell: map['forSell'],
      forRent: map['forRent'],
      userId: map['userId'],
      creationTime: DateTime.fromMillisecondsSinceEpoch(map['creationTime']),
      available: map['available'],
      locationCode: map['locationCode'],
      locationName: map['locationName'],
    );
  }
}
// final List<File> selectedImg=[];
class ServiceInformationModel {
  String serviceName;
  TextEditingController? controller;
  List<File> selectedImages;
  String? serviceDetails;
  List<String>? imageUrl;
  bool isSelected;
  bool mustUploadImg;
  ServiceInformationModel({
    required this.serviceName,
    this.controller,
    this.selectedImages= const [],
    this.serviceDetails,
    this.imageUrl,
    this.isSelected = false,
    this.mustUploadImg = false
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceName': serviceName,
      'serviceDetails': controller!.text,
      'imageUrl': imageUrl,
    };
  }

  factory ServiceInformationModel.fromMap(Map<String, dynamic> map) {
    return ServiceInformationModel(
      serviceName: map['serviceName'],
      serviceDetails: map['serviceDetails'],
      imageUrl: List<String>.from((map['imageUrl'] ) ), 
      ///selectedImages: [],    
    );
  }
  // ServiceInformationModel copyWith({
  //   required String serviceName,
  //   required TextEditingController controller,
  //   List<File>? selectedImages,
  //   String? serviceDetails,
  //   List<String>? imageUrl,
  //   bool isSelected=false,
  //   required bool mustUploadImg,
  // }) {
  //   return ServiceInformationModel(
  //     serviceName: serviceName ,
  //     controller: controller ,
  //     selectedImages: this.selectedImages,
  //     serviceDetails:  this.serviceDetails,
  //     imageUrl: this.imageUrl,
  //     isSelected: this.isSelected ,
  //     mustUploadImg: mustUploadImg,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ServiceInformationModel.fromJson(String source) => ServiceInformationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'ServiceInformationModel(serviceName: $serviceName, controller: $controller, selectedImages: $selectedImages, serviceDetails: $serviceDetails, imageUrl: $imageUrl, isSelected: $isSelected, mustUploadImg: $mustUploadImg)';
  // }


}
