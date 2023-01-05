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
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

class GetBorrowPostNotifier
    extends StateNotifier<ApiState<List<BorrowPostModel>>> {
  GetBorrowPostNotifier() : super(const ApiState.initial()) {
    allBorrowPosts();
  }

  // StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? streamSubscription;

  Future<void> allBorrowPosts() async {
    state = const ApiState.loading();
    try {
      FirebaseConstants.borrowPostsCollection
          .orderBy("postTime",descending: true)
          .get()
          .then((event) {
        List<BorrowPostModel> _posts = [];
        List<BorrowPostModel> _postsWithDistance = [];
        if (event.docs.isNotEmpty) {
           for (var element in event.docs) {
            _posts.add(BorrowPostModel.fromMap(element.data()));
          }
           for (var borrowPost in _posts) {
            GeoPoint _userLocation = getGeoPointFromLocationModel(
                UserLocations.userLocations[0]);
            GeoPoint _postLocation =
                (borrowPost.locationCode["geopoint"] as GeoPoint);
            double distance = getDistanceBetweenTwoGeoPointQuery(
                _userLocation, _postLocation);
             borrowPost.distance = distance;   
            _postsWithDistance.add(
              borrowPost);
          }         
        }
        _postsWithDistance.sort((a, b) => (a.distance).compareTo(b.distance));
        state = ApiState.loaded(data: _postsWithDistance);
      });
    } catch (e) {
      state = ApiState.error(
        error: NetworkExceptions.getErrorMessage(
          NetworkExceptions.getDioException(e),
        ),
      );
    }
  }
  // Comparator<BorrowPostModel> sortByLocation = (a, b) => a.locationCode.compareTo(b.locationCode);

}

class BorrowPostNotifier extends StateNotifier<ApiState<String>> {
  BorrowPostNotifier() : super(const ApiState.initial());
  Future<void> addNewBorrowPost(
      BorrowPostModel borrowPostModel, BuildContext context) async {
    try {
      await FirebaseConstants.borrowPostsCollection
          .doc(borrowPostModel.id)
          .set(borrowPostModel.toMap())
          .then((value) {
        EasyLoading.showSuccess("Post is uploaded");
        Navigator.pop(context);
      });
    } catch (e) {
      EasyLoading.showError("Something went wrong!");
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      errorPopup(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }
  Future<void> updateBorrowPost(
      BorrowPostModel borrowPostModel, BuildContext context) async {
    try {
      await FirebaseConstants.borrowPostsCollection
          .doc(borrowPostModel.id)
          .update(borrowPostModel.toMap())
          .then((value) {
        EasyLoading.showSuccess("Post is updated");
        Navigator.pop(context);
      });
    } catch (e) {
      EasyLoading.showError("Something went wrong!");
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      errorPopup(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }
  Future<void> deleteBorrowPost(
      String postId, BuildContext context) async {
    try {
      await FirebaseConstants.borrowPostsCollection
          .doc(postId)
          .delete()
          .then((value) {
        EasyLoading.showSuccess("Post is deleted");
        Navigator.pop(context);
      });
    } catch (e) {
      EasyLoading.showError("Something went wrong!");
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

