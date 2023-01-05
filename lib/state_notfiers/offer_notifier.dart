import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/helper/network_exceptions.dart';
import 'package:protibeshi_app/models/offer/offer.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

class OfferNotifier extends StateNotifier<ApiState<String>> {
  OfferNotifier() : super(const ApiState.initial());
  Future<void> addNewOffer(OfferModel offerModel) async {
    try {
      FirebaseConstants.offerCollection
          .doc(offerModel.id)
          .set(offerModel.toMap());
      EasyLoading.showSuccess("offer sent!");
    } catch (e) {
      EasyLoading.showError("Something went wrong!");
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      errorPopup(err);
      print(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }

  Future<void> acceptOffer(OfferModel offer) async {
    try {
      print("offer accepted : ${offer.offerAccepted.toString()}");
      print("offer id : ${offer.id}");
      print("offer offerCancelled : ${offer.offerCancelled.toString()}");
      FirebaseConstants.offerCollection
          .doc(offer.id)
          .update(offer.toMap());
      EasyLoading.showSuccess("Accepted");
    } catch (e) {
      EasyLoading.showError("Something went wrong!");
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      errorPopup(err);
      print(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }

  Future<void> cancelOffer(OfferModel offer) async {
    try {
      FirebaseConstants.offerCollection
          .doc(offer.id)
          .update(offer.toMap())
          .whenComplete(() => EasyLoading.showSuccess("Cancelled!!"));
    } catch (e) {
      EasyLoading.showError("Something went wrong!");
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      errorPopup(err);
      print(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }
}

class GetOfferNotifier
    extends StateNotifier<ApiState<List<OfferModel>>> {
  GetOfferNotifier() : super(const ApiState.initial()) {
    getOffers();
  }

  // StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? streamSubscription;

  Future<void> getOffers() async {
    state = const ApiState.loading();
    try {
      List<OfferModel> _lists = [];
      FirebaseConstants.offerCollection
          .orderBy("offerSentTime", descending: true)
          .get()
          .then((event) {
        if (event.docs.isNotEmpty) {
          _lists.clear();
          for (var element in event.docs) {
            _lists.add(OfferModel.fromMap(element.data()));
          }
        }
        state = ApiState.loaded(data: _lists);
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
