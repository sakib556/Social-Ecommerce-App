import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/models/user/cover_picture_model.dart';
import 'package:protibeshi_app/models/user/profile_picture_model.dart';

import 'package:protibeshi_app/models/user/user_basic_model.dart';
import 'package:protibeshi_app/providers/user_provider.dart';
// import 'package:protibeshi_app/views/other_pages/loading.dart';
import 'package:protibeshi_app/views/other_pages/something_went_wrong.dart';

class UserBasicBuilder extends ConsumerWidget {
  final Widget Function(
          BuildContext context, UserBasicModel userBasicModel, bool isOnline)
      builder;
  final String? userId;
  const UserBasicBuilder({
    Key? key,
    this.userId,
    required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userBasicDetails =
        userbasicInfoProvider(userId ?? FirebaseAuth.instance.currentUser!.uid);
    final getUserOnlineStatus = getUserOnlineStatusProvider(
        userId ?? FirebaseAuth.instance.currentUser!.uid);
    return ref.watch(userBasicDetails).maybeMap(
        orElse: () => Container(),
        error: (_) => const SomethingWentWrong(),
        loaded: (userdata) {
          return ref.watch(getUserOnlineStatus).maybeMap(
              orElse: () => Container(),
              error: (_) => const SomethingWentWrong(),
              loaded: (isOnline) => builder(context, userdata.data, isOnline.data));
        });
  }
}
class UserPictureBuilder extends ConsumerWidget {
  final Widget Function(
          BuildContext context,List<ProfilePictureModel> profilePictures, List<CoverPictureModel> coverPictures)
      builder;
  final String? userId;

  const UserPictureBuilder({
    Key? key,
    this.userId,
    required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ref.watch(userCoverPicturesProvider(
                            userId ?? FirebaseAuth.instance.currentUser!.uid)).maybeMap(
        orElse: () =>  Container(),
        error: (_) => const SomethingWentWrong(),
        loaded: (coverPictureModel) {
          return ref.watch(userProfilePicturesProvider(
                            userId ?? FirebaseAuth.instance.currentUser!.uid)).maybeMap(
              orElse: () => Container(),
              error: (_) => const SomethingWentWrong(),
              loaded: (profilePictureModel) => builder(context, profilePictureModel.data, coverPictureModel.data));
        });
  }
}