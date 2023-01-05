import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/providers/user_provider.dart';
import 'package:badges/badges.dart' as badge;
class UserAvatar extends ConsumerWidget {
  final double size;
  final String? userId;

  const UserAvatar({
    Key? key,
    this.size = 20,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final _userProfilePictures = userProfilePicturesProvider(userId ?? FirebaseAuth.instance.currentUser!.uid);
    final _getOnlineStatus = getUserOnlineStatusProvider(userId ?? FirebaseAuth.instance.currentUser!.uid);
    return ref.watch(_userProfilePictures).maybeMap(
      error: (_) => Container(),
      orElse: () => Container(),
      loaded: (pictures) => 
                pictures.data.isNotEmpty 
                     ? ref.watch(_getOnlineStatus)
                           .maybeMap(
                              orElse:() => Padding(
                                  padding: EdgeInsets.all(size / 2),
                                  child: Icon(
                                    Icons.person,
                                    size: size,
                                  ),
                                ),
                              error: (_) => Padding(
                              padding: EdgeInsets.all(size / 2),
                              child: Icon(
                                Icons.person,
                                size: size,
                              ),
                            ),
                              loaded: (_) =>  
                                Stack(
                                children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      clipBehavior: Clip.hardEdge,
                                      child: Container(
                                        color: Theme.of(context).colorScheme.onSurface
                                            .withOpacity(0.40),
                                        child:  CachedNetworkImage(
                                                imageUrl: pictures
                                                    .data.first.imageUrl,
                                                width: size * 2,
                                                height: size * 2,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    _.data
                                        ? Positioned(
                                            bottom: 2,
                                            right: 2,
                                            child: badge.Badge(
                                              elevation: 0,
                                              animationType:
                                                  badge.BadgeAnimationType.fade,
                                              badgeColor: Theme.of(context).colorScheme.primary,
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              loading: (_)=> 
                                Padding(
                                  padding: EdgeInsets.all(size / 2),
                                  child: Icon(
                                    Icons.person,
                                    size: size,
                                  ),
                                )) 
                     : Padding( padding: EdgeInsets.all(size / 2),
                                child: Icon(
                                            Icons.person,
                                            size: size,
                                            ),));}
  static Widget otherUserAvatar(BuildContext context, double size) {
    return UserAvatar(size: size);
  }
}
