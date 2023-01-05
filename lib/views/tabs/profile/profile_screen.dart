import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:protibeshi_app/models/user/location_model.dart';
import 'package:protibeshi_app/providers/catgory_provider.dart';
import 'package:protibeshi_app/providers/post_provider.dart';
import 'package:protibeshi_app/providers/user_provider.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_basic_builder.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_location_builder.dart';
import 'package:protibeshi_app/views/others/space_horizontal.dart';
import 'package:protibeshi_app/views/tabs/call/call_screen.dart';
import 'package:protibeshi_app/views/tabs/home/components/home_post/home_post.dart';
import 'package:protibeshi_app/views/tabs/profile/components/edit_profile/edit_add_bio.dart';
import 'package:protibeshi_app/views/tabs/profile/components/edit_profile/edit_profile.dart';
import 'package:protibeshi_app/views/tabs/profile/components/listings/my_listings.dart';
import 'package:protibeshi_app/views/tabs/profile/settings/settings_screen.dart';
import 'package:protibeshi_app/views/tabs/profile/components/user_locations.dart';
import 'package:protibeshi_app/themes/colors.dart';
import 'package:protibeshi_app/models/user/user_basic_model.dart';
import 'package:protibeshi_app/views/tabs/profile/components/profile_cover_and_avatar.dart';

// import 'package:url_launcher/url_launcher.dart' ;
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key, this.uid}) : super(key: key);
  final String? uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: uid == null
            ? AppBar(
                centerTitle: false,
                title: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserLocations()));
                  },
                  child: const UserLocationPin(),
                ),
                actions: [
                  IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none_outlined,
                        // color: MyColors.blackColor,
                      )),
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsScreen()));
                    },
                    icon: const Icon(
                      Icons.menu_outlined,
                      // color: MyColors.blackColor,
                    ),
                  )
                ],
              )
            : AppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            await ref.read(getBikeProductProvider.notifier).allBikeList();
            await ref.read(getBookProductProvider.notifier).allBookList();
            await ref.read(getServiceProvider.notifier).allServiceList();
            await ref.read(getTeachingProvider.notifier).allServiceList();
            await ref.read(getBorrowPostsProvider.notifier).allBorrowPosts();
          },
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    children: [
                      //Get Profile Cover and Avatar
                      ref
                          .watch(userCoverPicturesProvider(
                              uid ?? FirebaseAuth.instance.currentUser!.uid))
                          .maybeMap(
                              error: (_) => Container(),
                              orElse: () => Container(),
                              loaded: (coverPic) => ref
                                  .watch(userProfilePicturesProvider(uid ??
                                      FirebaseAuth.instance.currentUser!.uid))
                                  .maybeMap(
                                      error: (_) => Container(),
                                      orElse: () => Container(),
                                      loaded: (profilePic) =>
                                          ProfileCoverAndAvatar(
                                            coverPictures: coverPic.data,
                                            profilePictures: profilePic.data,
                                            myProfile:
                                                uid == null ? true : false,
                                          ))),
                      //Get Profile Info and bio
                      UserBasicBuilder(
                          userId: uid,
                          builder: (context, userBasicModel, isOnline) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ProfileInfo(
                                  userBasicModel: userBasicModel,
                                  myProfile: uid == null ? true : false,
                                ),
                                //Get User Badge and Level
                                const UserBadgeAndLevel(),
                                ProfileBio(
                                  userBasicModel: userBasicModel,
                                  myProfile: uid == null ? true : false,
                                ),
                                const UserTaskAndHelpedStats(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const UserWalletAmount(),
                                    if (uid != null)
                                      UserPhoneCall(
                                        receiverId: uid ?? "",
                                      )
                                  ],
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ]),
              ),
              const SliverAppBar(
                automaticallyImplyLeading: false,
                title: TabBar(
                  // labelColor: MyColors.primaryColor,
                  // indicatorColor: MyColors.primaryColor,
                  // unselectedLabelColor: MyColors.blackColor,
                  tabs: [
                    Tab(icon: Text("LISTINGS")),
                    Tab(icon: Text("POSTS")),
                    Tab(icon: Text("ABOUT")),
                  ],
                ),
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      children: [
                        // const Icon(Icons.directions_transit),
                        MyListings(uid: uid),
                        MyPosts(uid: uid),
                        const Icon(Icons.directions_bike),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyPosts extends ConsumerWidget {
  const MyPosts({Key? key, this.uid}) : super(key: key);
  final String? uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PostItemList(
      sortIndex: 1,
      uid: uid,
      singleUser: true,
    );
  }
}

class UserLocationPin extends StatelessWidget {
  const UserLocationPin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.location_pin,
          color: MyColors.primaryColor,
          size: 16,
        ),
        const SizedBox(
          width: 3,
        ),
        Flexible(
          child: UserLocationBuilder(
            builder: (context, location) {
              LocationModel? _home;

              if (location.isNotEmpty) {
                for (var l in location) {
                  if (l.locationType == 1) {
                    _home = l;
                  }
                }
              }

              return Text(
                "${_home?.house}, ${_home?.street}, ${_home?.area}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    Theme.of(context).textTheme.caption!.copyWith(fontSize: 12),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProfileBio extends StatelessWidget {
  final UserBasicModel userBasicModel;
  final bool myProfile;
  const ProfileBio({
    Key? key,
    required this.userBasicModel,
    required this.myProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: userBasicModel.bio == null
          ? myProfile
              ? TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditAddBioScreen(),
                      ),
                    );
                  },
                  child: const Text("Add Bio"))
              : const SizedBox()
          : Text(userBasicModel.bio!,
              style: Theme.of(context).textTheme.caption),
    );
  }
}

class UserWalletAmount extends StatelessWidget {
  const UserWalletAmount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.money_dollar_circle,
            color: MyColors.greenColor,
          ),
          const SizedBox(width: 5),
          Text(
            "4,560 BDT",
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class UserPhoneCall extends StatelessWidget {
  const UserPhoneCall({Key? key, required this.receiverId}) : super(key: key);
  final String receiverId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CallingScreen(receiverId: receiverId)),
        );
        //  VideoSDKQuickStart
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            const Icon(
              Icons.call,
              color: MyColors.greenColor,
            ),
            const SizedBox(width: 5),
            Text(
              "Call now",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class UserTaskAndHelpedStats extends StatelessWidget {
  const UserTaskAndHelpedStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(
            Icons.task_alt,
            color: MyColors.primaryColor,
          ),
          const SizedBox(width: 5),
          Text(
            "135 tasks given",
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(width: 12),
          Container(width: 1, color: MyColors.secondaryColor, height: 16),
          const SizedBox(width: 12),
          Text(
            "Helped 630 neighbors",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}

class UserBadgeAndLevel extends StatelessWidget {
  const UserBadgeAndLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: [
          const Icon(
            FontAwesomeIcons.crown,
            size: 14,
            color: MyColors.goldColor,
          ),
          const SizedBox(width: 9),
          Text(
            "Gold Member",
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(width: 12),
          Container(width: 1, color: MyColors.secondaryColor, height: 16),
          const SizedBox(width: 12),
          Text(
            "Level 2 Seller",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final UserBasicModel userBasicModel;
  final bool myProfile;
  const ProfileInfo({
    Key? key,
    required this.userBasicModel,
    required this.myProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SpaceHorizontal(15),
                    Text(
                      userBasicModel.name ?? "No name",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    userBasicModel.isVerified
                        ? const Icon(
                            Icons.verified_user,
                            color: MyColors.verifiedColor,
                          )
                        : const Icon(
                            Icons.verified_user,
                            color: MyColors.verifiedColor,
                          ),
                  ],
                ),
              ),
              if (myProfile)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                  child: const Icon(
                    FontAwesomeIcons.solidEdit,
                    size: 18,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
//ProfileScreen - UserWalletAmount,UserTaskAndHelpedStats,UserBadgeAndLevel function needed


  