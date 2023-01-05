import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/helper/get_distance_from_lat_lang.dart';
import 'package:protibeshi_app/helper/get_geo_point.dart';
import 'package:protibeshi_app/helper/network_exceptions.dart';
import 'package:protibeshi_app/models/listing/category/teaching_model.dart';
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

final TextEditingController swimmingController = TextEditingController(),
    cookingController = TextEditingController(),
    gardeningControllers = TextEditingController(),
    electronicsController = TextEditingController(),
    artsController = TextEditingController(),
    graphicsController = TextEditingController(),
    programingController = TextEditingController(),
    design3DController = TextEditingController(),
    msOfficeController = TextEditingController(),
    videoEditingController = TextEditingController(),
    musicalInstrumentController = TextEditingController(),
    othersController = TextEditingController();

final List<TeachingInformationModel> techingDefaultItems = [
  TeachingInformationModel(
      serviceName: "Swimming",
      mustUploadImg: false,
      controller: swimmingController,
      selectedImages: []
      ),
  TeachingInformationModel(
      serviceName: "Cooking",
       mustUploadImg: true, 
       controller: cookingController,
      selectedImages: []
      ),
  TeachingInformationModel(
      serviceName: "Gardening",
      mustUploadImg: false,
      controller: gardeningControllers,
      selectedImages: []),
  TeachingInformationModel(
      serviceName: "Electronics",
      mustUploadImg: false,
      controller: electronicsController,
      selectedImages: []),
  TeachingInformationModel(
      serviceName: "Arts and Crafts",
      mustUploadImg: true,
      controller: artsController,
      selectedImages: []),
  TeachingInformationModel(
      serviceName: "Graphics Design",
      mustUploadImg: true,
      controller: graphicsController,
      selectedImages: []),
  TeachingInformationModel(
      serviceName: "Computer Programing",
      mustUploadImg: true,
      controller: programingController,
      selectedImages: []),
  TeachingInformationModel(
      serviceName: "3D Design",
      mustUploadImg: true,
      controller: design3DController,
      selectedImages: []),
  TeachingInformationModel(
      serviceName: "Microsoft Office or Google Docs",
      mustUploadImg: true,
      controller: msOfficeController,
      selectedImages: []),
  TeachingInformationModel(
      serviceName: "Video Editing",
      mustUploadImg: true,
      controller: videoEditingController,
      selectedImages: []),
  TeachingInformationModel(
      serviceName: "Musical Instrument",
      mustUploadImg: true,
      controller: musicalInstrumentController,
      selectedImages: []),
  TeachingInformationModel(
      serviceName: "Others",
      mustUploadImg: true,
      controller: othersController,
      selectedImages: []),
];

class TeachingItemNotifier extends StateNotifier<List<TeachingInformationModel>> {
  TeachingItemNotifier() : super(techingDefaultItems) ;
  void toggle(TeachingInformationModel serviceTypeModel) {
    state = state
        .map((value) => value.serviceName == serviceTypeModel.serviceName
            ? TeachingInformationModel(
                serviceName: serviceTypeModel.serviceName,
                serviceDetails: serviceTypeModel.serviceDetails,
                imageUrl: serviceTypeModel.imageUrl,
                mustUploadImg: serviceTypeModel.mustUploadImg,
                isSelected: !serviceTypeModel.isSelected,
                controller: value.controller, 
                selectedImages: serviceTypeModel.selectedImages)
            : value)
        .toList();
  }
}

class TeachingListNotifier extends StateNotifier<ApiState<String>> {
  TeachingListNotifier() : super(const ApiState.initial());
  Future<void> addTeachingListing(
      TeachingModel teachingModel, BuildContext context) async {
    try {
      print("read running");
      await FirebaseConstants.listingCollection
          .doc(teachingModel.id)
          .set(teachingModel.toMap())
          .then((value) {
            print("read end");
      //  EasyLoading.showSuccess("Listing added successfully.");
       // Navigator.pop(context);
      });
      print("read end rp");
    } catch (e) {
      EasyLoading.showError("Something went wrong! \n$e");
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      errorPopup(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }

  Future<void> updateTeachingListing(
      TeachingModel teachingModel, BuildContext context) async {
    try {
      await FirebaseConstants.listingCollection
          .doc(teachingModel.id)
          .update(teachingModel.toMap())
          .then((value) {
        EasyLoading.showSuccess("Listing updated successfully.");
        Navigator.pop(context);
      });
    } catch (e) {
      EasyLoading.showError("Something went wrong! \n$e");
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      errorPopup(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }

  Future<void> deleteTeachingListing(
      TeachingModel teachingModel, BuildContext context) async {
    try {
      await FirebaseConstants.listingCollection
          .doc(teachingModel.id)
          .delete()
          .then((value) {
        EasyLoading.showSuccess("Listing deleted successfully.");
        Navigator.pop(context);
      });
    } catch (e) {
      EasyLoading.showError("Something went wrong! \n$e");
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      errorPopup(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }
}

class GetTeachingListNotifier
    extends StateNotifier<ApiState<List<TeachingModel>>> {
  GetTeachingListNotifier() : super(const ApiState.initial()) {
    allServiceList();
  }

  Future<void> allServiceList() async {
    state = const ApiState.loading();
    try {
      List<TeachingModel> _lists = [];
      List<TeachingModel> _listsWithDistance = [];
      print("loaded 1");
      await FirebaseConstants.listingCollection
          .where("categoryId", isEqualTo: "Teaching")
          .orderBy("creationTime", descending: true)
          .get()
          .then((event) {
        print("loaded 2");
        if (event.docs.isNotEmpty) {
          print("loaded 3");
          for (var element in event.docs) {
            print("loaded 4");
            _lists.add(TeachingModel.fromMap(element.data()));
            print("loaded 5");
          }
          for (var serviceList in _lists) {
            GeoPoint _userLocation =
                getGeoPointFromLocationModel(UserLocations.userLocations[0]);
            GeoPoint _postLocation =
                (serviceList.locationCode["geopoint"] as GeoPoint);
            double distance = getDistanceBetweenTwoGeoPointQuery(
                _userLocation, _postLocation);
            _listsWithDistance.add(TeachingModel(
              subCategoryId: serviceList.subCategoryId,
              userId: serviceList.userId,
              categoryId: serviceList.categoryId,
              creationTime: serviceList.creationTime,
              available: serviceList.available,
              locationCode: serviceList.locationCode,
              id: serviceList.id,
              teachingInformation: serviceList.teachingInformation,
              costFirstDay: serviceList.costFirstDay,
              costPerExtraDay: serviceList.costPerExtraDay,
              locationName: serviceList.locationName,
              distance: distance,
              forRent: serviceList.forRent,
              forSell: serviceList.forSell,
              costPerHour: serviceList.costPerHour,
              originalPrice: serviceList.originalPrice,
              sellPrice: serviceList.sellPrice,
            ));
          }
          print("loaded 6");
          _listsWithDistance.sort((a, b) => (a.distance).compareTo(b.distance));
        }
      });
      state = ApiState.loaded(data: _listsWithDistance);
      print("loaded 7");
    } catch (e) {
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );

      errorPopup(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }

}
