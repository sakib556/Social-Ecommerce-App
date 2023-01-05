import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/models/user/cover_picture_model.dart';
import 'package:protibeshi_app/models/user/location_model.dart';
import 'package:protibeshi_app/models/user/profile_picture_model.dart';
import 'package:protibeshi_app/models/user/user_basic_model.dart';
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:protibeshi_app/themes/colors.dart';

//New Codes of riverpod
final userbasicInfoProvider = 
    StateNotifierProvider.autoDispose.family<UserbasicInfoNotifier, ApiState<UserBasicModel>,String>(
        (ref,uid) => UserbasicInfoNotifier(uid));
final userProfilePicturesProvider = 
    StateNotifierProvider.autoDispose.family<UserProfilePicturesNotifier, ApiState<List<ProfilePictureModel>>,String>(
        (ref,uid) => UserProfilePicturesNotifier(uid));
final userCoverPicturesProvider = 
    StateNotifierProvider.autoDispose.family<UserCoverPicturesNotifier, ApiState<List<CoverPictureModel>>,String>(
        (ref,uid) => UserCoverPicturesNotifier(uid));
final userLocationsProvider = 
    StateNotifierProvider.autoDispose.family<UserLocationsNotifier, ApiState<List<LocationModel>>,String>(
        (ref,uid) => UserLocationsNotifier(uid));
final updateUserCoverPicProvider = 
    StateNotifierProvider<UpdateUserCoverPicNotifier, ApiState<String>>(
        (ref) => UpdateUserCoverPicNotifier
          (ref.watch(androidUiSettingsProvider), ref.watch(iosUiSettingsProvider), ref.watch(imagePickerProvider)));
final updateUserProfilePicProvider = 
    StateNotifierProvider<UpdateUserProfilePicNotifier, ApiState<String>>(
        (ref) => UpdateUserProfilePicNotifier
          (ref.watch(androidUiSettingsProvider), ref.watch(iosUiSettingsProvider), ref.watch(imagePickerProvider)));
final userBioUpdateProvider = 
    StateNotifierProvider<UserBioUpdateNotifier, ApiState<String>>(
      (ref) => UserBioUpdateNotifier());
final userFirstTimeUdateProfileProvider = 
    StateNotifierProvider<UserFirstTimeUdateProfileNotifier, ApiState<String>>(
      (ref) => UserFirstTimeUdateProfileNotifier());
final userUpdateNameProvider = 
    StateNotifierProvider<UserUpdateNameNotifier, ApiState<String>>(
      (ref) => UserUpdateNameNotifier());
final userPostionProvider = 
    StateNotifierProvider<UserPositionNotifier, ApiState<Position>>(
      (ref) => UserPositionNotifier());
final getUserOnlineStatusProvider = 
    StateNotifierProvider.autoDispose.family<GetUserOnlineStatusNotifier, ApiState<bool>,String>(
        (ref,uid) => GetUserOnlineStatusNotifier(uid));        
// some variable providers
final imagePickerProvider = Provider((ref) {
    final ImagePicker _picker = ImagePicker(); // done
  return _picker;
});

final androidUiSettingsProvider = Provider((ref) {
     const AndroidUiSettings _androidUiSettings = AndroidUiSettings(
    // done
    toolbarTitle: 'Crop Profile Picture',
    toolbarColor: MyColors.primaryColor,
    toolbarWidgetColor: MyColors.onPrimary,
    cropFrameColor: MyColors.primaryColor,
    statusBarColor: MyColors.primaryColor,
    activeControlsWidgetColor: MyColors.primaryColor,
    initAspectRatio: CropAspectRatioPreset.square,
    lockAspectRatio: true,
  );// done
  return _androidUiSettings;
});

final iosUiSettingsProvider = Provider((ref) {
  const _iosUiSettings = IOSUiSettings(
    // done
    minimumAspectRatio: 1.0,
    title: 'Crop Profile Picture',
    aspectRatioLockEnabled: true,
  );
 return _iosUiSettings;
});

final geoProvider = Provider((ref) {
    final Geoflutterfire _geo = Geoflutterfire(); // done
  return _geo;
});

//new class of static variables

class SetUserOnlineStatusProvider {
   static Future<void> setUserOnlineStatus(
      {required String uid, required bool status}) async {
    await FirebaseConstants.usersOnlineRef(uid).set(status);
  }
}

