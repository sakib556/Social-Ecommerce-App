import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/themes/colors.dart';
import 'package:protibeshi_app/models/user/cover_picture_model.dart';
import 'package:protibeshi_app/models/user/profile_picture_model.dart';
import 'package:protibeshi_app/providers/user_provider.dart';
import 'package:protibeshi_app/views/tabs/profile/components/user_image_viewer.dart';
// import 'package:provider/provider.dart';

class ProfileCoverAndAvatar extends ConsumerWidget {
  final List<ProfilePictureModel> profilePictures;
  final List<CoverPictureModel> coverPictures;
  final bool myProfile;
  const ProfileCoverAndAvatar({
    Key? key,
    required this.profilePictures,
    required this.coverPictures,
    required this.myProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     myProfile? ListTile(
                        title: Text(coverPictures.isEmpty
                            ? "Add Cover Photo"
                            : "Change Cover Photo"),
                        onTap: () async {
                          Navigator.pop(context);
                          await ref.watch(updateUserCoverPicProvider.notifier)
                                    .updateUserCoverPic(coverPictures.isEmpty
                                                            ? 0
                                                            : coverPictures.length);
                        },
                      ):const SizedBox(),
                      if (coverPictures.isNotEmpty ) 
                        ListTile(
                          title: const Text("View Cover Photo"),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserImageViewer(
                                  imageUrl: coverPictures.first.imageUrl,
                                  userName: FirebaseAuth
                                      .instance.currentUser!.displayName,
                                  time: coverPictures.first.time, 
                                  myProfile:myProfile,
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              );
            },
            child: Card(
              elevation: 0,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: coverPictures.isEmpty
                      ? Container(
                          color: MyColors.blackColor.withOpacity(0.08),
                          child: const Center(
                            child: Opacity(
                              opacity: 0.54,
                              child: Icon(Icons.add_a_photo_outlined),
                            ),
                          ),
                        )
                      : Hero(
                          tag: coverPictures.first.imageUrl,
                          child: CachedNetworkImage(
                              imageUrl: coverPictures.first.imageUrl,
                              fit: BoxFit.cover),
                        ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 16,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(8),
                    // color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if(myProfile)
                        ListTile(
                          title: Text(profilePictures.isEmpty
                              ? "Add Profile Photo"
                              : "Change Profile Photo"),
                          onTap: () async {
                            Navigator.pop(context);
                            await ref.watch(updateUserProfilePicProvider.notifier)
                                      .updateUserProfilePic(
                                         profilePictures.isEmpty
                                           ? 0
                                           : profilePictures.length);
                          },
                        ),
                        if (profilePictures.isNotEmpty)
                          ListTile(
                            title: const Text("View Profile Photo"),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserImageViewer(
                                    imageUrl: profilePictures.first.imageUrl,
                                    userName: FirebaseAuth
                                        .instance.currentUser!.displayName,
                                    time: profilePictures.first.time,
                                    myProfile:myProfile
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 3),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.40),
                    child: profilePictures.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(
                              Icons.person,
                              size: 60,
                            ),
                          )
                        : Hero(
                            tag: profilePictures.first.imageUrl,
                            child: CachedNetworkImage(
                              imageUrl: profilePictures.first.imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
 
}
