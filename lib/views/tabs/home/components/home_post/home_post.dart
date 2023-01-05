import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/date_formatter.dart';
import 'package:protibeshi_app/helper/get_distance_from_lat_lang.dart';
import 'package:protibeshi_app/helper/get_geo_point.dart';
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/post_builder.dart';
import 'package:protibeshi_app/views/custom_widgets/user_avatar.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_location_builder.dart';
import 'package:protibeshi_app/views/custom_widgets/user_name.dart';
import 'package:protibeshi_app/views/others/space_horizontal.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/tabs/dashboard/components/colour_button.dart';
import 'package:protibeshi_app/views/tabs/home/components/borrow/create_borrow_post_page_view.dart';
import 'package:protibeshi_app/views/tabs/home/components/choose_post_type_modal_sheet.dart';
import 'package:protibeshi_app/themes/colors.dart';
import 'package:protibeshi_app/views/tabs/home/components/my_listing_screen.dart';
import 'package:protibeshi_app/views/tabs/home/components/view%20images/view_post_images.dart';
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:protibeshi_app/providers/post_provider.dart';
import 'package:protibeshi_app/views/tabs/profile/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePostScreen extends ConsumerWidget {
  const HomePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        return ref.read(getBorrowPostsProvider.notifier).allBorrowPosts();
      },
      child: Column(
        // controller: _homeController.homeScrollController,
        children: const [
          SpaceVertical(16),
          CreateNewPostSection(),
          HomePostListSection(),
        ],
      ),
    );
  }
}

class HomePostListSection extends StatefulWidget {
  const HomePostListSection({
    Key? key,
  }) : super(key: key);
  @override
  State<HomePostListSection> createState() => _HomePostListSectionState();
}

class _HomePostListSectionState extends State<HomePostListSection> {
  int sortIndex = 0;

  @override
  Widget build(BuildContext context) {
    final onSurfaceTextColour =
        Theme.of(context).colorScheme.onSurface.withOpacity(0.5);
    final onSurfaceBorderColour =
        Theme.of(context).colorScheme.onSurface.withOpacity(0.2);
    final onSurfaceBackgColour =
        Theme.of(context).colorScheme.onSurface.withOpacity(0.05);
    final primaryColour = Theme.of(context).colorScheme.primary;
    final primaryBackgColour =
        Theme.of(context).colorScheme.primary.withOpacity(0.1);
    const orangeColour = Colors.orange;
    final orangeBackgColour = Colors.orange.withOpacity(0.1);
    print("object3");
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ColourButton(
                      selectedIndex: sortIndex,
                      title: "Nearby",
                      constIndex: 0,
                      backgroundColor: sortIndex == 0
                          ? orangeBackgColour
                          : onSurfaceBackgColour,
                      borderColor:
                          sortIndex == 0 ? orangeColour : onSurfaceBorderColour,
                      titleColor:
                          sortIndex == 0 ? orangeColour : onSurfaceTextColour,
                      onPressed: () {
                        setState(() {
                          sortIndex = 0;
                        });
                      }),
                  const SpaceHorizontal(5),
                  ColourButton(
                    selectedIndex: sortIndex,
                    title: "Latest",
                    constIndex: 1,
                    backgroundColor: sortIndex == 1
                        ? orangeBackgColour
                        : onSurfaceBackgColour,
                    borderColor:
                        sortIndex == 1 ? orangeColour : onSurfaceBorderColour,
                    titleColor:
                        sortIndex == 1 ? orangeColour : onSurfaceTextColour,
                    onPressed: () {
                      setState(() {
                        sortIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PostItemList(
              sortIndex: sortIndex,
              singleUser: false,
            ),
          ),
        ],
      ),
    );
  }
}

class PostItemList extends ConsumerWidget {
  // final List<BorrowPostModel> postList;
  final int sortIndex;
  final String? uid;
  final bool singleUser;
  const PostItemList({
    Key? key,
    this.uid,
    required this.sortIndex,
    required this.singleUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserLocationBuilder(
      builder: (context, locationModels) => PostBuilder(
        builder: (context, postList) {
          final String userId =
              uid ?? FirebaseConstants.firebaseInstance.currentUser!.uid;
          final posts = singleUser
              ? postList.where((post) => post.userId == userId).toList()
              : postList.where((post) => post.userId != userId).toList();
          sortIndex == 1
              ? posts.sort((a, b) => (b.postTime).compareTo(a.postTime))
              : null;
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: posts.map((borrowPost) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileScreen(uid: borrowPost.userId),
                                    ),
                                  );
                                },
                                child: UserAvatar(userId: borrowPost.userId)),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfileScreen(
                                              uid: borrowPost.userId),
                                        ),
                                      );
                                    },
                                    child: UserName(userId: borrowPost.userId)),
                                borrowPost.userId ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? const SizedBox()
                                    : UserLocationBuilder(
                                        builder: (context, locationModels) {
                                          if (UserLocations.userAllLocations
                                                  .isNotEmpty &&
                                              UserLocations.userAllLocations
                                                      .first.geoLocation !=
                                                  null) {
                                            GeoPoint _userLocation =
                                                getGeoPointFromLocationModel(
                                                    UserLocations
                                                        .userAllLocations[0]);
                                            GeoPoint _postLocation = (borrowPost
                                                    .locationCode["geopoint"]
                                                as GeoPoint);

                                            String _distance =
                                                getDistanceBetweenTwoGeoPoint(
                                                    _userLocation,
                                                    _postLocation);

                                            return Text(
                                              _distance,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            );
                                          } else {
                                            return Text(
                                              borrowPost.locationName,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            );
                                          }
                                        },
                                      ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  borrowPost.userId ==
                                          FirebaseConstants
                                              .firebaseInstance.currentUser!.uid
                                      ? InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) => Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ListTile(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CreateBorrowPostPageView(
                                                                    borrowPost:
                                                                        borrowPost,
                                                                  )), //need changes to listed page
                                                        );
                                                      },
                                                      title: Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.edit),
                                                          const SpaceHorizontal(
                                                              2),
                                                          Text(
                                                            "Edit post",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6,
                                                          ),
                                                        ],
                                                      ),
                                                      subtitle: const Text(
                                                          "Edit your post now."),
                                                    ),
                                                    ListTile(
                                                      onTap: () {
                                                        ref
                                                            .read(
                                                                borrowPostProvider
                                                                    .notifier)
                                                            .deleteBorrowPost(
                                                                borrowPost.id,
                                                                context);
                                                        ref
                                                            .read(
                                                                getBorrowPostsProvider
                                                                    .notifier)
                                                            .allBorrowPosts();
                                                      },
                                                      title: Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.delete),
                                                          const SpaceHorizontal(
                                                              2),
                                                          Text(
                                                            "Delete post",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6,
                                                          ),
                                                        ],
                                                      ),
                                                      subtitle: const Text(
                                                          "Delete your post now."),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            ".....",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : const SizedBox(),
                                  const SpaceVertical(8),
                                  Text(
                                    DateFormatter.toTime(borrowPost.postTime),
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontSize: 10),
                                  ),
                                  Text(
                                    DateFormatter.toDMY(borrowPost.postTime),
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        PostText(postText: borrowPost.postText),
                        const SizedBox(
                          height: 8,
                        ),
                        if (borrowPost.postImages.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewPostImages(
                                      borrowPostModel: borrowPost),
                                ),
                              );
                            },
                            child: PostImages(
                              post: borrowPost,
                            ),
                          ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "BUDGET",
                                  style: Theme.of(context).textTheme.overline,
                                ),
                                Text(
                                  "${borrowPost.postBudget}/day",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        color: MyColors.priceColor,
                                      ),
                                ),
                              ],
                            ),
                            OfferHelpButton(borrowPost: borrowPost),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              );
            }).toList(),
          );
        },
        isLoading: true,
      ),
    );
  }
}

class OfferHelpButton extends StatelessWidget {
  final BorrowPostModel borrowPost;
  const OfferHelpButton({
    Key? key,
    required this.borrowPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // void _onTapChat() async {
    //   Navigator.pop(context);
    //   EasyLoading.show(status: "Opening Chat...");

    //   await ChatRepo.getConversationId(borrowPost.userId).then((value) async {
    //     if (value == null) {
    //       await ChatRepo.createConversation(borrowPost.userId).then((v) {
    //         if (v != null) {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => ChatPage(
    //                 otherUserId: borrowPost.userId,
    //                 conversationId: v,
    //               ),
    //             ),
    //           );
    //         }
    //       });
    //     } else {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => ChatPage(
    //             otherUserId: borrowPost.userId,
    //             conversationId: value,
    //           ),
    //         ),
    //       );
    //     }
    //   });

    //   EasyLoading.dismiss();
    // }

    return borrowPost.userId == FirebaseAuth.instance.currentUser!.uid
        ? const SizedBox()
        : OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                  width: 1.0, color: Theme.of(context).colorScheme.onSurface),
            ),
            child: const Text("Offer help"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyListingPage(
                        borrowPost: borrowPost)), //need changes to listed page
              );
              // showModalBottomSheet(
              //   context: context,
              //   builder: (context) => Container(
              //     padding: const EdgeInsets.all(8),
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         ListTile(
              //           onTap: () {
              //             Navigator.pop(context);
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => MyListingPage (borrowPost: borrowPost)
              //                    ), //need changes to listed page
              //             );
              //           },
              //           title: Text(
              //             "Give an offer",
              //             style: Theme.of(context).textTheme.headline6,
              //           ),
              //           subtitle:
              //               const Text("Earn money helping your neighbor"),
              //         ),
              //         ListTile(
              //           onTap: _onTapChat,
              //           title: Text(
              //             "Chat",
              //             style: Theme.of(context).textTheme.headline6,
              //           ),
              //           subtitle: const Text("Communicate to know more"),
              //         ),
              //       ],
              //     ),
              //   ),
              // );
            },
          );
  }
}

class PostImages extends StatelessWidget {
  final BorrowPostModel post;
  const PostImages({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: post.postImages.length == 1
          ? PostSingleImage(imageUrl: post.postImages.first)
          : post.postImages.length == 2
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: PostSingleImage(imageUrl: post.postImages.first),
                    ),
                    Expanded(
                      child: PostSingleImage(imageUrl: post.postImages.last),
                    )
                  ],
                )
              : post.postImages.length == 3
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                  child: PostSingleImage(
                                imageUrl: post.postImages[0],
                              )),
                              Expanded(
                                child: PostSingleImage(
                                  imageUrl: post.postImages[1],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: PostSingleImage(
                            imageUrl: post.postImages.last,
                          ),
                        )
                      ],
                    )
                  : post.postImages.length == 4
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: PostSingleImage(
                                    imageUrl: post.postImages[0],
                                  )),
                                  Expanded(
                                    child: PostSingleImage(
                                      imageUrl: post.postImages[1],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: PostSingleImage(
                                    imageUrl: post.postImages[2],
                                  )),
                                  Expanded(
                                    child: PostSingleImage(
                                      imageUrl: post.postImages[3],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: PostSingleImage(
                                    imageUrl: post.postImages[0],
                                  )),
                                  Expanded(
                                    child: PostSingleImage(
                                      imageUrl: post.postImages[1],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: PostSingleImage(
                                    imageUrl: post.postImages[2],
                                  )),
                                  Expanded(
                                    child: PostSingleImage(
                                      moreNumberOfImages:
                                          "${post.postImages.length - 3}+",
                                      imageUrl: post.postImages[3],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
    );
  }
}

class PostSingleImage extends StatelessWidget {
  final String imageUrl;
  final String? moreNumberOfImages;
  const PostSingleImage({
    Key? key,
    required this.imageUrl,
    this.moreNumberOfImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.surface, width: 2),
          image: moreNumberOfImages != null
              ? DecorationImage(image: NetworkImage(imageUrl))
              : null,
          // color: Theme.of(context).colorScheme.surface,
        ),
        child: moreNumberOfImages == null
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              )
            : Container(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.47),
                child: Center(
                  child: Text(
                    moreNumberOfImages!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ));
  }
}

class PostText extends StatefulWidget {
  final String postText;
  const PostText({
    Key? key,
    required this.postText,
  }) : super(key: key);

  @override
  State<PostText> createState() => _PostTextState();
}

class _PostTextState extends State<PostText> {
  int _maxLInes = 3;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _maxLInes = _maxLInes > 3 ? 3 : 99999;
        });
      },
      child: Text(
        widget.postText,
        textAlign: TextAlign.start,
        maxLines: _maxLInes,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
      ),
    );
  }
}

class CreateNewPostSection extends StatelessWidget {
  const CreateNewPostSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 0,
        bottom: 8,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          const UserAvatar(),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const ChoosePostTypeModalSheet(),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(.38)),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("Tell your neighbors",
                    style: Theme.of(context).textTheme.subtitle2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeLocationSection extends StatelessWidget {
  const HomeLocationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: On tap location in home
      },
      child: Container(
        padding: const EdgeInsets.only(top: 0, bottom: 8, left: 16, right: 16),
        child: Container(
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(
                width: 1,
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(.38)),
          )),
          child: Row(
            children: [
              const Expanded(child: UserLocationPin()),
              const SizedBox(
                width: 3,
              ),
              GestureDetector(
                onTap: () {
                  //TODO: Filter Radius
                },
                child: const Icon(
                  Icons.filter_list_outlined,
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
