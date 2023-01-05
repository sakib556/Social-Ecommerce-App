import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';

Future<String?> saveVPictures(File file, String title) async {
  //Verfication Document Uploader
  Reference _storageReference = FirebaseConstants.storage
      .ref()
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child("Verification Pictures")
      .child(title);

  String? _url;

  UploadTask _uploadTask = _storageReference.putFile(file);
  await _uploadTask.whenComplete(() async =>
      await _storageReference.getDownloadURL().then((value) => _url = value));
  return _url;
}
