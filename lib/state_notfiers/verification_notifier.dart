//Update User Name Saved
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/helper/network_exceptions.dart';
import 'package:protibeshi_app/models/user/get_verified_model.dart';
import 'package:protibeshi_app/models/user/verification_item_model.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

class UserVerificationNotifier
    extends StateNotifier<ApiState<VerificationModel>> {
  UserVerificationNotifier() : super(const ApiState.initial()) {
    getVerificationStatus();
  }
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? streamSubscription;

  Future<void> getVerificationStatus() async {
    state = const ApiState.loading();
    try {
      state = const ApiState.loading();
      streamSubscription =
          FirebaseConstants.verificationCollection.snapshots().listen((events) {
        VerificationModel vf = VerificationModel();
        if (events.docs.isNotEmpty) {
          for (final element in events.docs) {
            if (element.id == FirebaseVariables.photoID) {
              vf = vf.copyWith(
                  photoID: VerificationItemModel.fromMap(element.data()));
            } else if (element.id == FirebaseVariables.selfie) {
              vf = vf.copyWith(
                  selfie: VerificationItemModel.fromMap(element.data()));
            } else if (element.id == FirebaseVariables.utility) {
              vf = vf.copyWith(
                  utility: VerificationItemModel.fromMap(element.data()));
            }
          }
        }

        state = ApiState.loaded(data: vf);
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

class UserVerificationSubmissionNotifier
    extends StateNotifier<ApiState<String>> {
  UserVerificationSubmissionNotifier({required this.docname})
      : super(const ApiState.initial());
  final String docname;

  Future<void> submitVerificationForm(VerificationItemModel model) async {
    state = const ApiState.loading();
    try {
      await FirebaseConstants.verificationCollection
          .doc(docname)
          .set(model.toMap());
      EasyLoading.showSuccess("Successfully Uploaded");
      state = const ApiState.loaded(data: "Success");
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

//
class GetVerifiedStatusNotifier extends StateNotifier<ApiState<String>> {
  GetVerifiedStatusNotifier() : super(const ApiState.initial());

  Future<GetVerifiedModel?> getVerifiedStatuss() async {
    state = const ApiState.loading();
    try {
      return FirebaseConstants.verificationFormsCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        if (value.exists) {
          return GetVerifiedModel.fromMap(value.data()!);
        } else {
          return null;
        }
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
    return null;
  }
}

class SubmitVerificationFormNotifier extends StateNotifier<ApiState<String>> {
  SubmitVerificationFormNotifier() : super(const ApiState.initial());

  Future<void> submitVerificationForm(GetVerifiedModel model) async {
    state = const ApiState.loading();
    try {
      await FirebaseConstants.verificationFormsCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(model.toMap());
    } catch (e) {
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      EasyLoading.showError("Something went wrong!");
      errorPopup(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }
}

class UpdateVerificationFormNotifier extends StateNotifier<ApiState<String>> {
  UpdateVerificationFormNotifier() : super(const ApiState.initial());

  Future<void> updateVerificationForm(GetVerifiedModel model) async {
    state = const ApiState.loading();
    try {
      await FirebaseConstants.verificationFormsCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(model.toMap());
    } catch (e) {
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      EasyLoading.showError("Something went wrong!");
      errorPopup(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }
}
