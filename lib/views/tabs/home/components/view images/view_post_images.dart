import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';

class ViewPostImages extends StatelessWidget {
  final BorrowPostModel borrowPostModel;
  const ViewPostImages({
    Key? key,
    required this.borrowPostModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          PageView(
            children: borrowPostModel.postImages
                .map((e) => PhotoView(
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      imageProvider: CachedNetworkImageProvider(e),
                    ))
                .toList(),
          ),
        ],
      )),
    );
  }
}
