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
import 'package:protibeshi_app/models/listing/sub_category/bike_model.dart';
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

class BikeProductNotifier extends StateNotifier<ApiState<String>> {
  BikeProductNotifier() : super(const ApiState.initial());
  Future<void> addNewBike(BikeModel bikeModel, BuildContext context) async {
    try {
      await FirebaseConstants.listingCollection
          .doc(bikeModel.id)
          .set(bikeModel.toMap())
          .then((value) {
        EasyLoading.showSuccess("Listing is uploaded.");
        Navigator.pop(context);
      });
    } catch (e) {
      EasyLoading.showError("Something went wrong! \n${e.toString()}");
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

class GetBikeProductNotifier extends StateNotifier<ApiState<List<BikeModel>>> {
  GetBikeProductNotifier() : super(const ApiState.initial()) {
    allBikeList();
  }
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? streamSubscription;

  Future<void> allBikeList() async {
    state = const ApiState.loading();
    try {
      await FirebaseConstants.listingCollection
          .where("subCategoryId", isEqualTo: "Bike")
          .orderBy("creationTime", descending: true)
          .get()
          .then((event) {
        List<BikeModel> _lists = [];
        List<BikeModel> _listsWithDistance = [];
        if (event.docs.isNotEmpty) {
          for (var element in event.docs) {
            _lists.add(BikeModel.fromMap(element.data()));
          }
          for (var bookList in _lists) {
            GeoPoint _userLocation =
                getGeoPointFromLocationModel(UserLocations.userLocations[0]);
            GeoPoint _postLocation =
                (bookList.locationCode["geopoint"] as GeoPoint);
            double distance = getDistanceBetweenTwoGeoPointQuery(
                _userLocation, _postLocation);
            bookList.distance = distance;
            _listsWithDistance.add(bookList);
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
