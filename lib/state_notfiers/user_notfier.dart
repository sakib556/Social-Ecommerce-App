import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/helper/network_exceptions.dart';
import 'package:protibeshi_app/models/user/cover_picture_model.dart';
import 'package:protibeshi_app/models/user/location_model.dart';
import 'package:protibeshi_app/models/user/profile_picture_model.dart';
import 'package:protibeshi_app/models/user/user_basic_model.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

// Users basic Info State Notfier-1
class UserbasicInfoNotifier extends StateNotifier<ApiState<UserBasicModel>> {
  UserbasicInfoNotifier(this.uid) : super(const ApiState.initial()) {
    userBasicDetails();
  }
  final String
      uid; //making uid final so we can have mutiple instance using family
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _stream;

  Future<void> userBasicDetails() async {
    state = const ApiState.loading();
    try {
      _stream =
          FirebaseConstants.userCollection.doc(uid).snapshots().listen((event) {
        if (event.exists) {
          state = ApiState.loaded(data: UserBasicModel.fromMap(event.data()!));
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

  @override
  void dispose() {
    if (_stream != null) {
      _stream!.cancel();
    }
    super.dispose();
  }
}

//Users Profile Picture List State Notfier-2
class UserProfilePicturesNotifier
    extends StateNotifier<ApiState<List<ProfilePictureModel>>> {
  UserProfilePicturesNotifier(this.uid) : super(const ApiState.initial()) {
    userProfilePictures();
  }
  final String uid;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? streamSubscription;

  Future<void> userProfilePictures() async {
    state = const ApiState.loading();
    try {
     streamSubscription = FirebaseConstants.profilePicturesCollection
          .where("userId", isEqualTo: uid)
          .snapshots()
          .listen((event) {
            List<ProfilePictureModel> _list = [];
            if (event.docs.isNotEmpty) {
            for (var element in event.docs) {
            _list.add(ProfilePictureModel.fromMap(element.data()));
             }
        _list.sort((p1, p2) => p2.time.compareTo(p1.time));
      }
      state = ApiState.loaded(data: _list);
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

//Users Cover Picture List State Notfier-3
class UserCoverPicturesNotifier
    extends StateNotifier<ApiState<List<CoverPictureModel>>> {
  UserCoverPicturesNotifier(this.uid) : super(const ApiState.initial()) {
    userCoverPictures();
  }
  final String uid;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? streamSubscription; 
  Future<void> userCoverPictures() async {
    state = const ApiState.loading();
    try {
      streamSubscription = FirebaseConstants
          .coverPicturesCollection
          .where("userId", isEqualTo: uid)
          .snapshots()
          .listen((event) {
             List<CoverPictureModel> _list = [];
             if (event.docs.isNotEmpty) {
             for (var doc in event.docs) {
             _list.add(CoverPictureModel.fromMap(doc.data()));
              }
            _list.sort((p1, p2) => p2.time.compareTo(p1.time));
              }
             state = ApiState.loaded(data: _list);
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
//user locations variable
class UserLocations {
static LocationModel? _homeLocation;
static LocationModel? _workLocation;
static List<LocationModel> userLocations = [];
static LocationModel? get homeLocation => _homeLocation;
static LocationModel? get workLocation => _workLocation;
static List<LocationModel> get userAllLocations => userLocations;
}
//Users Saved Location List State Notfier-4
class UserLocationsNotifier
    extends StateNotifier<ApiState<List<LocationModel>>> {
  UserLocationsNotifier(this.uid) : super(const ApiState.initial()) {
    userLocations();
  }
  
  final String uid;
  Future<void> userLocations() async {
    state = const ApiState.loading();
    try {
      QuerySnapshot<Map<String, dynamic>> events = await FirebaseConstants
          .userLocationsCollection
          .where("userId", isEqualTo: uid)
          .get();
      if (events.docs.isNotEmpty) {
        List<LocationModel> _list = [];
        for (var element in events.docs) {
          _list.add(LocationModel.fromMap(element.data()));
        }
        if (_list.isNotEmpty) {
          for (var l in _list) {
            if (l.locationType == 1) {
              UserLocations._homeLocation = l;
            } else if (l.locationType == 2) {
              UserLocations._workLocation = l;
            }
          }
        }
        _list.sort((p1, p2) => p2.time.compareTo(p1.time));
        UserLocations.userLocations = _list;
        print("load done");
        state = ApiState.loaded(data: _list);
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
//static 
class SaveCurrentPositionNotifier {
  static Future<void> saveCurrentPosition(
      {required int locationType,
      required String house,
      required String street,
      required String area,
      LatLng? latlng}) async {
   try{
      final _geo = Geoflutterfire();
      List<Placemark> _placeMarks = [];
      GeoFirePoint? _geoLocation;
      if (latlng != null) {
       _placeMarks =
          await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
      _geoLocation =
          _geo.point(latitude: latlng.latitude, longitude: latlng.longitude);
      }

    Future<void> _saveNewLocation({String? id}) async {
      Placemark? _placemark = _placeMarks.isEmpty ? null : _placeMarks.first;
      String _id =
          "${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().millisecondsSinceEpoch}";
      await FirebaseConstants.userLocationsCollection.doc(id ?? _id).set(
          LocationModel(
                  id: id ?? _id,
                  userId: FirebaseAuth.instance.currentUser!.uid,
                  area: area,
                  house: house,
                  street: street,
                  city: _placemark?.locality,
                  country: _placemark?.country,
                  geoLocation: _geoLocation?.data,
                  locationType: locationType,
                  time: DateTime.now())
              .toMap());
    }

    if (UserLocations._homeLocation != null && locationType == 1) {
      print("object1");
      print("id: ${UserLocations._homeLocation!.id}");
      _saveNewLocation(id: UserLocations._homeLocation!.id);
    } else if (UserLocations._workLocation != null && locationType == 2) {
      print("object2");
      _saveNewLocation(id: UserLocations._workLocation!.id);
    } else {
      print("object3");
      _saveNewLocation();
    }
    } catch (e) {
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      errorPopup(err); //Shows Error PopUp
    }
  }
}
Future<Position> getCurrentPosition() async { //DONE
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  } else {
    Position _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    return _position;
  }
}

//Users Cover photo upload State Notfier-5
class UpdateUserCoverPicNotifier extends StateNotifier<ApiState<String>> {
  UpdateUserCoverPicNotifier(
      this._androidUiSettings, this._iosUiSettings, this._picker)
      : super(const ApiState.initial());
  final AndroidUiSettings _androidUiSettings;
  final IOSUiSettings _iosUiSettings;
  final ImagePicker _picker;

  Future<void> updateUserCoverPic(int coverNumber) async {
    state = const ApiState.loading();
    try {
      EasyLoading.show(status: "Updating Cover Picture...");
      await _picker.pickImage(source: ImageSource.gallery).then((image) async {
        File? _croppedFile = await ImageCropper().cropImage(
          sourcePath: image!.path,
          aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
          maxHeight: 700,
          compressQuality: 20,
          androidUiSettings: _androidUiSettings,
          iosUiSettings: _iosUiSettings,
        );

        if (_croppedFile == null) {
          EasyLoading.dismiss();
        } else {
          Reference _storageReference = FirebaseConstants.storage
              .ref()
              .child(FirebaseAuth.instance.currentUser!.uid)
              .child("Cover Pictures")
              .child("cover$coverNumber");

          UploadTask _uploadTask = _storageReference.putFile(_croppedFile);
          await _uploadTask.whenComplete(() {
            _storageReference.getDownloadURL().then((fileURL) async {
              await FirebaseConstants.coverPicturesCollection.add(
                  CoverPictureModel(
                          imageUrl: fileURL,
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          time: DateTime.now())
                      .toMap());

              EasyLoading.dismiss();

              EasyLoading.showSuccess("Cover picture is updated!");
            });
          });
        }
      });
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

//Users Profile photo upload State Notfier-6
class UpdateUserProfilePicNotifier extends StateNotifier<ApiState<String>> {
  UpdateUserProfilePicNotifier(
      this._androidUiSettings, this._iosUiSettings, this._picker)
      : super(const ApiState.initial());
  final AndroidUiSettings _androidUiSettings;
  final IOSUiSettings _iosUiSettings;
  final ImagePicker _picker;

  Future<void> updateUserProfilePic(int avatarNumber) async {
    state = const ApiState.loading();
    try {
      EasyLoading.show(status: "Updating Profile Picture...");

      await _picker.pickImage(source: ImageSource.gallery).then((image) async {
        File? _croppedFile = await ImageCropper().cropImage(
          sourcePath: image!.path,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          maxHeight: 500,
          compressQuality: 20,
          androidUiSettings: _androidUiSettings,
          iosUiSettings: _iosUiSettings,
        );

        if (_croppedFile == null) {
          EasyLoading.dismiss();
        } else {
          Reference _storageReference = FirebaseConstants.storage
              .ref()
              .child(FirebaseAuth.instance.currentUser!.uid)
              .child("Profile Pictures")
              .child("avatar$avatarNumber");

          UploadTask _uploadTask = _storageReference.putFile(_croppedFile);
          await _uploadTask.whenComplete(() {
            _storageReference.getDownloadURL().then((fileURL) async {
              await FirebaseAuth.instance.currentUser!.updatePhotoURL(fileURL);
              await FirebaseConstants.profilePicturesCollection.add(
                  ProfilePictureModel(
                          imageUrl: fileURL,
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          time: DateTime.now())
                      .toMap());
              // userProfilePicturesProvider(FirebaseAuth.instance.currentUser!.uid);
              // UserProfilePicturesNotifier;
              EasyLoading.dismiss();
              EasyLoading.showSuccess("Profile picture is updated!");
            });
          });
        }
      });

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
//Users UserBioUpdateNotifier State Notfier-7
class UserBioUpdateNotifier extends StateNotifier<ApiState<String>> {
  UserBioUpdateNotifier() : super(const ApiState.initial());
  Future<void> addUpdateBio(String bio) async {
    state = const ApiState.loading();
    try {
      await FirebaseConstants.userCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {"bio": bio},
      );

      EasyLoading.showSuccess("Your bio is updated!");
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
//First Time User Profile Saved - 8
class UserFirstTimeUdateProfileNotifier extends StateNotifier<ApiState<String>> {
  UserFirstTimeUdateProfileNotifier() : super(const ApiState.initial());

  Future<void> updateProfileFirstTime() async {
    state = const ApiState.loading();
    try {
      await FirebaseConstants.userCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {'isProfileSaved': true},
      );
      state = const ApiState.loaded(data: "Success");
      EasyLoading.showSuccess("Saved! success");
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

//Update User Name Saved -9
class UserUpdateNameNotifier extends StateNotifier<ApiState<String>> {
  UserUpdateNameNotifier() : super(const ApiState.initial());

  Future<void> updateName(String name) async {
    state = const ApiState.loading();
    try {
      await FirebaseConstants.userCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {"name": name},
      );
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

//Update User Name Saved -10
class UserPositionNotifier extends StateNotifier<ApiState<Position>> {
  UserPositionNotifier() : super(const ApiState.initial());

  Future<void> getCurrentPosition(String name) async {
    state = const ApiState.loading();
    try {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      state = const ApiState.error(
        error: 'Location permissions are denied',
      );
      
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    state = const ApiState.error(
        error: 'Location permissions are permanently denied, we cannot request permissions.',
      );
    
  } else {
    Position _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    state=ApiState.loaded(data: _position);
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

class GetUserOnlineStatusNotifier extends StateNotifier<ApiState<bool>> {
  GetUserOnlineStatusNotifier(this.uid) : super(const ApiState.initial()) {
    getUserOnlineStatus();
  }
  final String
      uid; //making uid final so we can have mutiple instance using family
  StreamSubscription<Event>? _stream;

  Future<void> getUserOnlineStatus() async {
    state = const ApiState.loading();
    try {
      _stream =  FirebaseConstants.usersOnlineRef(uid).onValue.listen((event) {
          state = ApiState.loaded(data: event.snapshot.value ?? false);
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
  @override
  void dispose() {
    if (_stream != null) {
      _stream!.cancel();
    }
    super.dispose();
  }
}


// class SaveCurrentPositionNotifier extends StateNotifier<ApiState<String>> {
//   SaveCurrentPositionNotifier() : super(const ApiState.initial());
//   // Future<void> saveCurrentPosition(
//   //     {required int locationType,
//   //     required String house,
//   //     required String street,
//   //     required String area,
//   //     LatLng? latlng}) async {
//   //   state = const ApiState.loading();
//   //   try {
//   //     List<Placemark> _placeMarks = [];
//   //     GeoFirePoint? _geoLocation;
//   //     if (latlng != null) {
//   //       _placeMarks =
//   //           await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
//   //       _geoLocation =
//   //           _geo.point(latitude: latlng.latitude, longitude: latlng.longitude);
//   //     }

//   //     if (_homeLocation != null && locationType == 1) {
//   //       _saveNewLocation(id: _homeLocation!.id);
//   //     } else if (_workLocation != null && locationType == 2) {
//   //       _saveNewLocation(id: _workLocation!.id);
//   //     } else {
//   //       _saveNewLocation();
//   //     }

//   //     state = const ApiState.loaded(data: "Success");
//   //   } catch (e) {
//   //     String err = NetworkExceptions.getErrorMessage(
//   //       NetworkExceptions.getDioException(e),
//   //     );
//   //     errorPopup(err); //Shows Error PopUp
//   //     state = ApiState.error(
//   //       error: err,
//   //     );
//   //   }
//   // }

//   // Future<void> _saveNewLocation({String? id}) async {
//   //       Placemark? _placemark = _placeMarks.isEmpty ? null : _placeMarks.first;
//   //       String _id =
//   //           "${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().millisecondsSinceEpoch}";
//   //       await FirebaseConstants.userLocationsCollection.doc(id ?? _id).set(
//   //           LocationModel(
//   //                   id: id ?? _id,
//   //                   userId: FirebaseAuth.instance.currentUser!.uid,
//   //                   area: area,
//   //                   house: house,
//   //                   street: street,
//   //                   city: _placemark?.locality,
//   //                   country: _placemark?.country,
//   //                   geoLocation: _geoLocation?.data,
//   //                   locationType: locationType,
//   //                   time: DateTime.now())
//   //               .toMap());
//   //     }
// }
//Update User Bio - 8
