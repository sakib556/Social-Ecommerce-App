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
import 'package:protibeshi_app/models/listing/category/service_model.dart';
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

final TextEditingController shoppingController = TextEditingController(),
    makeUpController = TextEditingController(),
    cleaningController = TextEditingController(),
    techSupportController = TextEditingController(),
    cookingController = TextEditingController(),
    photographyController = TextEditingController(),
    graphicsController = TextEditingController();
final List<ServiceInformationModel> serviceDefaultItems = [
  ServiceInformationModel(
      serviceName: "Shopping",
      mustUploadImg: false,
      controller: shoppingController,
      selectedImages: []
      ),
  ServiceInformationModel(
      serviceName: "Makeup",
       mustUploadImg: true, 
       controller: makeUpController,
      selectedImages: []
      ),
  ServiceInformationModel(
      serviceName: "Cleaning",
      mustUploadImg: false,
      controller: cleaningController,
      selectedImages: []),
  ServiceInformationModel(
      serviceName: "Tech-support",
      mustUploadImg: false,
      controller: techSupportController,
      selectedImages: []),
  ServiceInformationModel(
      serviceName: "Cooking",
      mustUploadImg: true,
      controller: cookingController,
      selectedImages: []),
  ServiceInformationModel(
      serviceName: "Photography",
      mustUploadImg: true,
      controller: photographyController,
      selectedImages: []),
  ServiceInformationModel(
      serviceName: "Graphics Design",
      mustUploadImg: true,
      controller: graphicsController,
      selectedImages: []),
];

class ServiceItemNotifier extends StateNotifier<List<ServiceInformationModel>> {
  ServiceItemNotifier() : super(serviceDefaultItems) ;
  void toggle(ServiceInformationModel serviceTypeModel) {
    state = state
        .map((value) => value.serviceName == serviceTypeModel.serviceName
            ? ServiceInformationModel(
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

class ServiceListNotifier extends StateNotifier<ApiState<String>> {
  ServiceListNotifier() : super(const ApiState.initial());
  Future<void> addServiceListing(
      ServiceModel serviceModel, BuildContext context) async {
    try {
      print("read running");
      await FirebaseConstants.listingCollection
          .doc(serviceModel.id)
          .set(serviceModel.toMap())
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

  Future<void> updateServiceListing(
      ServiceModel serviceModel, BuildContext context) async {
    try {
      await FirebaseConstants.listingCollection
          .doc(serviceModel.id)
          .update(serviceModel.toMap())
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

  Future<void> deleteServiceListing(
      ServiceModel serviceModel, BuildContext context) async {
    try {
      await FirebaseConstants.listingCollection
          .doc(serviceModel.id)
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

class GetServiceListNotifier
    extends StateNotifier<ApiState<List<ServiceModel>>> {
  GetServiceListNotifier() : super(const ApiState.initial()) {
    allServiceList();
  }

  Future<void> allServiceList() async {
    state = const ApiState.loading();
    try {
      List<ServiceModel> _lists = [];
      List<ServiceModel> _listsWithDistance = [];
      print("loaded 1");
      await FirebaseConstants.listingCollection
          .where("categoryId", isEqualTo: "Service")
          .orderBy("creationTime", descending: true)
          .get()
          .then((event) {
        print("loaded 2");
        if (event.docs.isNotEmpty) {
          print("loaded 3");
          for (var element in event.docs) {
            print("loaded 4");
            _lists.add(ServiceModel.fromMap(element.data()));
            print("loaded 5");
          }
          for (var serviceList in _lists) {
            GeoPoint _userLocation =
                getGeoPointFromLocationModel(UserLocations.userLocations[0]);
            GeoPoint _postLocation =
                (serviceList.locationCode["geopoint"] as GeoPoint);
            double distance = getDistanceBetweenTwoGeoPointQuery(
                _userLocation, _postLocation);
            _listsWithDistance.add(ServiceModel(
              subCategoryId: serviceList.subCategoryId,
              userId: serviceList.userId,
              categoryId: serviceList.categoryId,
              creationTime: serviceList.creationTime,
              available: serviceList.available,
              locationCode: serviceList.locationCode,
              id: serviceList.id,
              serviceInformation: serviceList.serviceInformation,
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
