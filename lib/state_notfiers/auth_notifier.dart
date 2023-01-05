import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/helper/network_exceptions.dart';
import 'package:protibeshi_app/models/user/profile_picture_model.dart';
import 'package:protibeshi_app/models/user/user_basic_model.dart';
import 'package:protibeshi_app/providers/notification_provider.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

//Sign in with & out

class SignInWithPhoneNoNotifier extends StateNotifier<ApiState<String>> {
  SignInWithPhoneNoNotifier() : super(const ApiState.initial());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  int? _resendToken;
  bool _codeSent = false;

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  get currentUser {
    return _auth.currentUser;
  }

  Future verifyPhoneNumber(String phoneNumber) async {
    EasyLoading.show(status: 'Wait...');
    await _auth.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
    }, verificationFailed: (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
    }, codeSent: (String verificationId, int? resendToken) {
      _verificationId = verificationId;
      _resendToken = resendToken;
      _codeSent = true;
    }, codeAutoRetrievalTimeout: (String verificationId) {
      _verificationId = verificationId;
    });
  }

  Future signWithOtp(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: otp);
    await _auth.signInWithCredential(credential);
  }
}

class SignInWithEmailAndPasswordNotifier
    extends StateNotifier<ApiState<String>> {
  SignInWithEmailAndPasswordNotifier() : super(const ApiState.initial());

  Future<void> signInWithEmailAndPassword(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    state = const ApiState.loading();
    try {
      EasyLoading.show(status: 'Logging in...');
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        await NotificationProvider.addDeviceTokens();
      });

      Navigator.pop(context);
      state = const ApiState.loaded(data: "Success");
      EasyLoading.dismiss();
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

class SignUpWithEmailAndPasswordNotifier
    extends StateNotifier<ApiState<String>> {
  SignUpWithEmailAndPasswordNotifier() : super(const ApiState.initial());

  Future<void> signUpWithEmailAndPassword(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    state = const ApiState.loading();
    try {
      EasyLoading.show(status: 'Signing up...');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        // Save to users
        await FirebaseConstants.userCollection.doc(value.user!.uid).set(
            UserBasicModel(
                    isProfileSaved: false,
                    id: value.user!.uid,
                    email: email,
                    joiningTime: DateTime.now())
                .toMap());

        await NotificationProvider.addDeviceTokens();
        Navigator.pop(context);
      });
      state = const ApiState.loaded(data: "Success");
      EasyLoading.dismiss();
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

class SignInWithGoogleNotifier extends StateNotifier<ApiState<String>> {
  SignInWithGoogleNotifier() : super(const ApiState.initial());

  Future<void> signInWithGoogle(BuildContext context,
      {bool willGoBack = false}) async {
    try {
      state = const ApiState.loading();
      EasyLoading.show(status: 'Logging in with google...');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          // Once signed in, return the UserCredential
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((userCredential) async {
            FirebaseConstants.userCollection.get().then(
              (querySnapshot) async {
                final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                    _userList = querySnapshot.docs;
                final List<String> _userUidList = [];
                for (var element in _userList) {
                  _userUidList.add(element.id);
                }

                if (!_userUidList.contains(userCredential.user!.uid)) {
                  //Save to Users
                  await FirebaseConstants.userCollection
                      .doc(userCredential.user!.uid)
                      .set(UserBasicModel(
                        isProfileSaved: false,
                        id: userCredential.user!.uid,
                        email: userCredential.user!.email!,
                        name: userCredential.user!.displayName,
                        joiningTime: DateTime.now(),
                      ).toMap());

                  await FirebaseConstants.profilePicturesCollection.add(
                    ProfilePictureModel(
                            imageUrl: userCredential.user!.photoURL!,
                            userId: userCredential.user!.uid,
                            time: DateTime.now())
                        .toMap(),
                  );
                }
              },
            );
            await NotificationProvider.addDeviceTokens();
          });
          state = const ApiState.loaded(data: "Success");
          EasyLoading.dismiss();
          EasyLoading.dismiss();
          if (willGoBack) {
            Navigator.pop(context);
          }
        } else {
          EasyLoading.dismiss();
          EasyLoading.showToast(
            "Something went wrong!",
            toastPosition: EasyLoadingToastPosition.bottom,
          );
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showToast(
          "Something went wrong!",
          toastPosition: EasyLoadingToastPosition.bottom,
        );
      }
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

class SignInWithFacebookNotifier extends StateNotifier<ApiState<String>> {
  SignInWithFacebookNotifier() : super(const ApiState.initial());
  Future<void> signInWithFacebook(BuildContext context,
      {bool willGoBack = false}) async {
    state = const ApiState.loading();
    EasyLoading.show(status: 'Logging in with facebook...');
    final LoginResult _result = await FacebookAuth.instance.login();

    if (_result.accessToken != null) {
      // Create a credential from the access token
      final _facebookAuthCredential =
          FacebookAuthProvider.credential(_result.accessToken!.token);
      try {
        // Once signed in, return the UserCredential
        await FirebaseAuth.instance
            .signInWithCredential(_facebookAuthCredential)
            .then((userCredential) async {
          FirebaseConstants.userCollection.get().then(
            (querySnapshot) async {
              final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                  _userList = querySnapshot.docs;
              final List<String> _userUidList = [];
              for (var element in _userList) {
                _userUidList.add(element.id);
              }
              if (!_userUidList.contains(userCredential.user!.uid)) {
                //Save to Users
                await FirebaseConstants.userCollection
                    .doc(userCredential.user!.uid)
                    .set(UserBasicModel(
                      isProfileSaved: false,
                      id: userCredential.user!.uid,
                      email: userCredential.user!.email!,
                      name: userCredential.user!.displayName,
                      joiningTime: DateTime.now(),
                    ).toMap());
                await FirebaseConstants.profilePicturesCollection.add(
                  ProfilePictureModel(
                          imageUrl: userCredential.user!.photoURL!,
                          userId: userCredential.user!.uid,
                          time: DateTime.now())
                      .toMap(),
                );
              }
            },
          );
          await NotificationProvider.addDeviceTokens();
        });
        state = const ApiState.loaded(data: "Success");
        EasyLoading.dismiss();

        if (willGoBack) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showToast(
          e.message ?? "Something went wrong!",
          toastPosition: EasyLoadingToastPosition.bottom,
          duration: const Duration(seconds: 3),
        );
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
}

class SignOutNotifier extends StateNotifier<ApiState<String>> {
  SignOutNotifier() : super(const ApiState.initial());
  Future<void> signOut(BuildContext context) async {
    try {
      await NotificationProvider.removeDeviceTokens().then((value) async {
        await FirebaseAuth.instance.signOut().then((value) async {
          await GoogleSignIn().signOut();
          await FacebookAuth.instance.logOut();
        });
      });
      EasyLoading.dismiss();
    } catch (e) {
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      errorPopup(err); //Shows Error PopUp
    }
  }
}

// others
class AuthStateChangeNotifier extends StateNotifier<ApiState<String>> {
  AuthStateChangeNotifier() : super(const ApiState.initial()) {
    authStateChanges();
  }
  Future<void> authStateChanges() async {
    state = const ApiState.loading();
    try {
      state = const ApiState.loading();
      FirebaseAuth.instance.authStateChanges().listen((event) {
        if (event == null) {
          state = const ApiState.loaded(data: "");
        } else {
          state = const ApiState.loaded(data: "success");
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
  }
}

class GoToLoginPageNotifier extends StateNotifier<ApiState<String>> {
  GoToLoginPageNotifier() : super(const ApiState.initial());
  void goToLoginPage(PageController pageController) {
    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }
}

class GoToSignUpPageNotifier extends StateNotifier<ApiState<String>> {
  GoToSignUpPageNotifier() : super(const ApiState.initial());
  void goToSignUpPage(PageController pageController) {
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }
}
