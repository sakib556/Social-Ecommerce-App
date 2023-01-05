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
import 'package:protibeshi_app/models/listing/sub_category/home_made_food_model.dart';
import 'package:protibeshi_app/providers/catgory_provider.dart';
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

class FoodGenreNotifier extends StateNotifier<List<CheckBoxModel>> {
  FoodGenreNotifier() : super([]) {
    getValue();
  }
  List<CheckBoxModel> genreList = [
    CheckBoxModel(id: 1, title: "Biriani", selected: false),
    CheckBoxModel(id: 2, title: "Teheri", selected: false),
    CheckBoxModel(id: 3, title: "Jilapi", selected: false),
    CheckBoxModel(id: 4, title: "Mutton", selected: false),
    CheckBoxModel(id: 5, title: "Hilsha Fish", selected: false),
    CheckBoxModel(id: 6, title: "Chicken", selected: false),
    CheckBoxModel(id: 7, title: "others", selected: false),
  ];
  int countValue = 0;
  void getValue() {
    state = genreList;
  }

  void toggle(CheckBoxModel checkBoxModel) {

    if (countValue < 3 || checkBoxModel.selected) {
      state = [
        for (final value in state)
          if (value.id == checkBoxModel.id)
            CheckBoxModel(
                id: value.id, title: value.title, selected: !value.selected)
          else
            value,
      ];
      if(checkBoxModel.selected) { 
        countValue=countValue-1; }
      print("value 1: $countValue");
    }
    if (!checkBoxModel.selected && countValue < 3 ) {
      countValue++;
      print("value 2: $countValue");
      }
  }

  void clearAll() {
    countValue = 0;
    state = [
      for (final value in state)
        CheckBoxModel(id: value.id, title: value.title, selected: false)
    ];
  }
}

class HomeMadeFoodListNotifier extends StateNotifier<ApiState<String>> {
  HomeMadeFoodListNotifier() : super(const ApiState.initial());
  Future<void> addHomeMadeFoodListing(HomeMadeFoodModel foodModel, BuildContext context) async {
    try {
      await FirebaseConstants.listingCollection
          .doc(foodModel.id)
          .set(foodModel.toMap())
          .then((value) {
        EasyLoading.showSuccess("Listing added successfully.");
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
  Future<void> updateHomeMadeFoodListing(HomeMadeFoodModel foodModel, BuildContext context) async {
    try {
      await FirebaseConstants.listingCollection
          .doc(foodModel.id)
          .update(foodModel.toMap())
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
  Future<void> deleteHomeMadeFoodListing(HomeMadeFoodModel foodModel, BuildContext context) async {
    try {
      await FirebaseConstants.listingCollection
          .doc(foodModel.id)
          .delete()
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


}

class GetHomeMadeFoodListNotifier extends StateNotifier<ApiState<List<HomeMadeFoodModel>>> {
  GetHomeMadeFoodListNotifier() : super(const ApiState.initial()) {
    allHomeMadeFoodList();
  }

  Future<void> allHomeMadeFoodList() async {
    state = const ApiState.loading();
    try {
      await FirebaseConstants.listingCollection
          .where("subCategoryId", isEqualTo: "Home-made Food")
          .orderBy("creationTime", descending: true)
          .get()
          .then((event) {
        List<HomeMadeFoodModel> _lists = [];
        List<HomeMadeFoodModel> _listsWithDistance = [];
        if (event.docs.isNotEmpty) {
          for (var element in event.docs) {
            _lists.add(HomeMadeFoodModel.fromMap(element.data()));
          }
          for (var foodList in _lists) {
            GeoPoint _userLocation =
                getGeoPointFromLocationModel(UserLocations.userLocations[0]);
            GeoPoint _postLocation =
                (foodList.locationCode["geopoint"] as GeoPoint);
            double distance = getDistanceBetweenTwoGeoPointQuery(
                _userLocation, _postLocation);
            _listsWithDistance.add(HomeMadeFoodModel(
                subCategoryId: foodList.subCategoryId,
                title: foodList.title,
                userId: foodList.userId,
                categoryId: foodList.categoryId,
                details: foodList.details,
                condition: foodList.condition,
                imageUrl: foodList.imageUrl,
                creationTime: foodList.creationTime,
                available: foodList.available,
                locationCode: foodList.locationCode,
                id: foodList.id,
                cuisine: foodList.cuisine,
                costFirstDay: foodList.costFirstDay,
                costPerExtraDay: foodList.costPerExtraDay,
                locationName: foodList.locationName,
                distance: distance, 
                forRent: foodList.forRent,
                forSell: foodList.forSell,
                ));
          }
        }
        _listsWithDistance.sort((a, b) => (a.distance).compareTo(b.distance));
        state = ApiState.loaded(data: _listsWithDistance);
      });
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