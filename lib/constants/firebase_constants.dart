import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _ref = FirebaseDatabase.instance.reference();

class FirebaseConstants {
  FirebaseConstants._();
  static final storage = FirebaseStorage.instance;
 static final firebaseInstance = FirebaseAuth.instance;
  static DatabaseReference userChatsRef(String userId) =>
      _ref.child('userChats').child(userId);

  static DatabaseReference userDeviceTokensRef(String userId, String token) =>
      _ref.child('userDeviceTokens').child(userId).child(token);

  static DatabaseReference messagesRef(String chatId) =>
      _ref.child('messages').child(chatId);

  static DatabaseReference usersOnlineRef(String userId) =>
      _ref.child('usersOnline').child(userId).child("isOnline");

  static final userCollection = FirebaseFirestore.instance.collection("users");
  static final verificationCollection = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(
          "verification"); // Verification Docs Stored in User Collection
  static final profilePicturesCollection =
      FirebaseFirestore.instance.collection("profilePictures");
  static final coverPicturesCollection =
      FirebaseFirestore.instance.collection("coverPictures");

  static final userDetailsCollection =
      FirebaseFirestore.instance.collection("userDetails");
  static final userLocationsCollection =
      FirebaseFirestore.instance.collection("userLocations");
  static final borrowPostsCollection =
      FirebaseFirestore.instance.collection("borrowPosts");
  static final listingCollection =
      FirebaseFirestore.instance.collection("listings");
  static final orderCollection =
      FirebaseFirestore.instance.collection("orders");
  static final offerCollection =
      FirebaseFirestore.instance.collection("offers");
  static final notificationCollection =
      FirebaseFirestore.instance.collection("notification");
  static final callCollection =
      FirebaseFirestore.instance.collection("calls");
  static DatabaseReference userBookRef(String userId) =>
      _ref.child('users').child(userId);
  static final verificationFormsCollection =
      FirebaseFirestore.instance.collection("verificationForms");
  static Future<List<String>> uploadFiles(
      {required List<File> images, required String fileName}) async {
    print("uploading..");
    return await Future.wait(images.map((_image) async {
      print("start");
      final storageReference = FirebaseStorage.instance
          .ref()
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(fileName)
          .child(_image.path.replaceAll("/", "_"));
      await storageReference.putFile(_image);
      print("start 2");
      // final uploadTask = storageReference.putFile(_image);
            // await uploadTask.whenComplete(() async {
      //   return await storageReference.getDownloadURL();
      // });
       print("uploaded..");
      return await storageReference.getDownloadURL();
    }));
  }

  static Future<void> deleteFiles({required List<String> images,required String fileName}) async {
    await Future.wait(images.map((_image) async {
      await FirebaseStorage.instance
          .ref()
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(fileName)
          .child(_image)
          .delete();
    }));
  }
}

class FirebaseVariables {
  FirebaseVariables._();
  static const String photoID = "photoID";
  static const String selfie = "selfie";
  static const String utility = "utility";
}
