import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/models/user/verification_item_model.dart';
import 'package:protibeshi_app/state_notfiers/verification_notifier.dart';

final verificationSubmissionProvider = StateNotifierProvider.family
    .autoDispose<UserVerificationSubmissionNotifier, ApiState<String>, String>(
        (ref, docname) {
  return UserVerificationSubmissionNotifier(docname: docname);
});
final verificationProvider =
    StateNotifierProvider<UserVerificationNotifier, ApiState<VerificationModel>>(
        (ref) {
  return UserVerificationNotifier();
});
//
final getVerifiedStatusProvider =
    StateNotifierProvider<GetVerifiedStatusNotifier, ApiState<String>>(
        (ref) {
  return GetVerifiedStatusNotifier();
});
final submitVerificationFormProvider =
    StateNotifierProvider<SubmitVerificationFormNotifier, ApiState<String>>(
        (ref) {
  return SubmitVerificationFormNotifier();
});
final updateVerificationFormProvider =
    StateNotifierProvider<UpdateVerificationFormNotifier, ApiState<String>>(
        (ref) {
  return UpdateVerificationFormNotifier();
});

// class VerificationProviderOld extends ChangeNotifier {
//   //Verification
//   Future<GetVerifiedModel?> getVerifiedStatus() async {
//     return FirebaseConstants.verificationFormsCollection
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get()
//         .then((value) {
//       if (value.exists) {
//         return GetVerifiedModel.fromMap(value.data()!);
//       } else {
//         return null;
//       }
//     });
//   }

//   Future<void> submitVerificationForm(GetVerifiedModel model) async {
//     try {
//       await FirebaseConstants.verificationFormsCollection
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .set(model.toMap());
//       notifyListeners();
//     } catch (e) {
//       EasyLoading.showError("Something went wrong!");
//     }
//   }

//   Future<void> updateVerificationForm(GetVerifiedModel model) async {
//     try {
//       await FirebaseConstants.verificationFormsCollection
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .update(model.toMap());
//       notifyListeners();
//     } catch (e) {
//       EasyLoading.showError("Something went wrong!");
//     }
//   }
// }
