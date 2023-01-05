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
import 'package:protibeshi_app/models/listing/sub_category/book_model.dart';
import 'package:protibeshi_app/providers/catgory_provider.dart';
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

class BookGenreNotifier extends StateNotifier<List<CheckBoxModel>> {
  BookGenreNotifier() : super([]) {
    getValue();
  }
  List<CheckBoxModel> genreList = [
    CheckBoxModel(id: 1, title: "Romance", selected: false),
    CheckBoxModel(id: 2, title: "Thriller", selected: false),
    CheckBoxModel(id: 3, title: "Horror", selected: false),
    CheckBoxModel(id: 4, title: "Fiction", selected: false),
    CheckBoxModel(id: 5, title: "Non-fiction", selected: false),
    CheckBoxModel(id: 6, title: "history", selected: false),
    CheckBoxModel(id: 7, title: "others", selected: false),
  ];
  int countValue = 0;
  void getValue() {
    state = genreList;
  }

  void toggle(CheckBoxModel checkBoxModel) {

    if (countValue < 3 || checkBoxModel.selected) {
      state = [
        // state.where((element) => element.id ==checkBoxModel.id)
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

class BookListNotifier extends StateNotifier<ApiState<String>> {
  BookListNotifier() : super(const ApiState.initial());
  Future<void> addBookListing(BookModel bookModel, BuildContext context) async {
    try {
      await FirebaseConstants.listingCollection
          .doc(bookModel.id)
          .set(bookModel.toMap())
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
  Future<void> updateBookListing(BookModel bookModel, BuildContext context) async {
    try {
      await FirebaseConstants.listingCollection
          .doc(bookModel.id)
          .update(bookModel.toMap())
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
  Future<void> deleteBookListing(BookModel bookModel, BuildContext context) async {
    try {
      await FirebaseConstants.listingCollection
          .doc(bookModel.id)
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

class GetBookListNotifier extends StateNotifier<ApiState<List<BookModel>>> {
  GetBookListNotifier() : super(const ApiState.initial()) {
    allBookList();
  }
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? streamSubscription;

  Future<void> allBookList() async {
    state = const ApiState.loading();
    try {
      await FirebaseConstants.listingCollection
          .where("subCategoryId", isEqualTo: "Book")
          .orderBy("creationTime", descending: true)
          .get()
          .then((event) {
        List<BookModel> _lists = [];
        List<BookModel> _listsWithDistance = [];
        if (event.docs.isNotEmpty) {
          for (var element in event.docs) {
            _lists.add(BookModel.fromMap(element.data()));
          }
          for (var bookList in _lists) {
            GeoPoint _userLocation =
                getGeoPointFromLocationModel(UserLocations.userLocations[0]);
            GeoPoint _postLocation =
                (bookList.locationCode["geopoint"] as GeoPoint);
            double distance = getDistanceBetweenTwoGeoPointQuery(
                _userLocation, _postLocation);
            _listsWithDistance.add(BookModel(
                subCategoryId: bookList.subCategoryId,
                title: bookList.title,
                userId: bookList.userId,
                categoryId: bookList.categoryId,
                details: bookList.details,
                condition: bookList.condition,
                imageUrl: bookList.imageUrl,
                creationTime: bookList.creationTime,
                available: bookList.available,
                locationCode: bookList.locationCode,
                id: bookList.id,
                bookAuthor: bookList.bookAuthor,
                genres: bookList.genres,
                costFirstDay: bookList.costFirstDay,
                costPerExtraDay: bookList.costPerExtraDay,
                locationName: bookList.locationName,
                distance: distance, 
                forRent: bookList.forRent,
                forSell: bookList.forSell,
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
