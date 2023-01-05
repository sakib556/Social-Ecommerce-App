import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/state_notfiers/auth_notifier.dart';

//Sign in with & out
final signInWithPhoneNoProvider =
    StateNotifierProvider<SignInWithPhoneNoNotifier, ApiState<String>>(
        (ref) => SignInWithPhoneNoNotifier());
final signInWithEmailAndPasswordProvider =
    StateNotifierProvider<SignInWithEmailAndPasswordNotifier, ApiState<String>>(
        (ref) => SignInWithEmailAndPasswordNotifier());
final signUpWithEmailAndPasswordProvider =
    StateNotifierProvider<SignUpWithEmailAndPasswordNotifier, ApiState<String>>(
        (ref) => SignUpWithEmailAndPasswordNotifier());
final signInWithGoogleProvider =
    StateNotifierProvider<SignInWithGoogleNotifier, ApiState<String>>(
        (ref) => SignInWithGoogleNotifier());
final signInWithFacebookProvider =
    StateNotifierProvider<SignInWithFacebookNotifier, ApiState<String>>(
        (ref) => SignInWithFacebookNotifier());
final signOutProvider =
    StateNotifierProvider<SignOutNotifier, ApiState<String>>(
        (ref) => SignOutNotifier());
//others
final authStateChangeProvider =
    StateNotifierProvider<AuthStateChangeNotifier, ApiState<String>>(
        (ref) => AuthStateChangeNotifier());
final pageControllerProvider = Provider((ref) => PageController());
final goToLoginPageProvider =
    StateNotifierProvider<GoToLoginPageNotifier, ApiState<String>>(
        (ref) => GoToLoginPageNotifier());
final goToSignUpPageProvider =
    StateNotifierProvider<GoToSignUpPageNotifier, ApiState<String>>(
        (ref) => GoToSignUpPageNotifier());
