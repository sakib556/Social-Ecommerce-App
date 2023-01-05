import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:protibeshi_app/themes/colors.dart';

class UserImageViewer extends StatelessWidget {
  final String imageUrl;
  final String? userName;
  final DateTime time;
  final bool myProfile;
  const UserImageViewer({
    Key? key,
    required this.imageUrl,
    required this.myProfile,
    this.userName,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: imageUrl,
                child: PhotoView(
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    imageProvider: CachedNetworkImageProvider(imageUrl)),
              ),
            ),
            if(myProfile)
            Positioned(
              bottom: 32,
              left: 16,
              child: Text(
                time.toString(),
                style: Theme.of(context)
                    .textTheme
                    .overline!
                    .copyWith(color: MyColors.secondaryColor),
              ),
            ),
            if(myProfile)
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                            color: MyColors.whiteColor,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text("Delete"),
                                  onTap: () {
                                    //TODO: Delete Image
                                  },
                                )
                              ],
                            ),
                          ));
                },
                icon: const Icon(Icons.more_vert),
              ),
            ),
            userName == null || !myProfile
                ? Container()
                : Positioned(
                    bottom: 48,
                    left: 16,
                    child: Text(
                      userName!,
                      style: Theme.of(context).textTheme.subtitle2!,
                    ),
                  ),
            const Positioned(
              child: BackButton(),
            ),
          ],
        ),
      ),
    );
  }
}
