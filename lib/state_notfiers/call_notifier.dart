import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/helper/network_exceptions.dart';
import 'package:protibeshi_app/models/call/call.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

class CallNotifier extends StateNotifier<ApiState<String>> {
  CallNotifier() : super(const ApiState.initial());
  Future<String> sendCall(CallModel callModel) async {
    String valueIs = "";
    try {
      await FirebaseConstants.callCollection
          .where("receiverId", isEqualTo: callModel.receiverId)
          .get()
          .then((value) async {
        if (value.docs.isEmpty) {
          print("added");
          await FirebaseConstants.callCollection
              .doc(callModel.id)
              .set(callModel.toMap())
              .then((value) {
            valueIs = "calling";
                print("added call");
          });
        }
        print("last");
      });
      return valueIs;
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
      return valueIs;
    }
 //   print("valuel $valueIs");
  //  return valueIs;
  }

  Future<void> cancelCall(String id) async {
    try {
      await FirebaseConstants.callCollection.doc(id).delete();
      EasyLoading.showSuccess("cancelled");
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

class GetCallNotifier extends StateNotifier<ApiState<List<CallModel>>> {
  GetCallNotifier() : super(const ApiState.initial()) {
    receiveCall();
  }

  // StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? streamSubscription;

  Future<void> receiveCall() async {
    state = const ApiState.loading();
    try {
      List<CallModel> _lists = [];
      FirebaseConstants.callCollection
          .where("receiverId",
              isEqualTo: FirebaseConstants.firebaseInstance.currentUser!.uid)
          .snapshots()
          .listen((event) {
        if (event.docs.isNotEmpty) {
          _lists.clear();
          for (var element in event.docs) {
            _lists.add(CallModel.fromMap(element.data()));
          }
          print("${_lists.length}");
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
}
