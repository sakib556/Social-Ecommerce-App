



import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:protibeshi_app/models/listing/parent_category_model.dart';

final List<String> teachingList = [
 "Swimming",
  "Cooking",
  "Gardening",
  "Electronics",
  "Arts and Crafts",
  "Graphics Design",
  "Computer Programing",
  "3D Design",
  "Microsoft Office or Google Docs",
  "Video Editing",
"Musical Instrument", 
"Others"
];
class TeachingModel extends ParentCategoryModel {
  TeachingInformationModel teachingInformation;
  
  TeachingModel(
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
      required this.teachingInformation})
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
      'serviceInformation': teachingInformation.toMap(),
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

  factory TeachingModel.fromMap(Map<String, dynamic> map) {
    return TeachingModel(
      teachingInformation : TeachingInformationModel.fromMap(map['serviceInformation']),
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
class TeachingInformationModel {
  String serviceName;
  TextEditingController? controller;
  List<File> selectedImages;
  String? serviceDetails;
  List<String>? imageUrl;
  bool isSelected;
  bool mustUploadImg;
  TeachingInformationModel({
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

  factory TeachingInformationModel.fromMap(Map<String, dynamic> map) {
    return TeachingInformationModel(
      serviceName: map['serviceName'],
      serviceDetails: map['serviceDetails'],
      imageUrl: List<String>.from((map['imageUrl'] ) ), 
      ///selectedImages: [],    
    );
  }


}
