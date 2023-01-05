import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/components/dotted_border_container.dart';

class ViewImages extends StatefulWidget {
  final VoidCallback onPressedBack;
  final List<File> selectedImages;
  final List<String>? imgLink;
  const ViewImages({
    Key? key,
    required this.onPressedBack,
    required this.selectedImages,
    this.imgLink,
  }) : super(key: key);
  @override
  State<ViewImages> createState() => _ViewImagesState();
}

class _ViewImagesState extends State<ViewImages> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  void _onPressedGallery() async {
    await _picker.pickMultiImage(imageQuality: 30).then((value) async {
      if (value != null) {
        for (var item in value) {
          setState(() {
            widget.selectedImages.add(File(item.path));
          });
        }
      }
    });
  }

  void _onPressedCamera() async {
    await _picker
        .pickImage(source: ImageSource.camera, imageQuality: 30)
        .then((value) async {
      if (value != null) {
        setState(() {
          widget.selectedImages.add(File(value.path));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return widget.selectedImages.isEmpty && widget.imgLink == null
        ? Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
            child: DottedBorderContainer(
                onPressed: _onPressedGallery, width: width, hasText: true),
          )
        : Wrap(
            children: [
              ...widget.selectedImages.map((e) {
                return ImageBox(
                  width: width,
                  e: e,
                  onPressedCross: () {
                    setState(() {
                      widget.selectedImages
                          .removeAt(widget.selectedImages.indexOf(e));
                    });
                  },
                  imgLink: widget.imgLink,
                );
                // SizedBox(
                //   width: width / 2,
                //   child: Stack(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(4.0),
                //         child: Image.file(e, fit: BoxFit.cover),
                //       ),
                //       Positioned(
                //         right: 0,
                //         top: 0,
                //         child: IconButton(
                //           onPressed: () {
                //             setState(() {
                //               widget.selectedImages
                //                   .removeAt(widget.selectedImages.indexOf(e));
                //             });
                //           },
                //           icon: const Icon(Icons.cancel),
                //         ),
                //       ),
                //     ],
                //   ),
                // );
              }).toList(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: DottedBorderContainer(
                    height: 150,
                    onPressed: _onPressedGallery,
                    width: width / 2,
                    hasText: false),
              )
            ],
          );
  }
}

class ImageBox extends StatelessWidget {
  const ImageBox(
      {Key? key,
      required this.width,
      required this.onPressedCross,
      this.imgLink,
      required this.e})
      : super(key: key);
  final double width;
  final void Function() onPressedCross;
  final List<String>? imgLink;
  final File e;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width / 2,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.file(e, fit: BoxFit.cover),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              onPressed: () {
                onPressedCross();
              },
              icon: const Icon(Icons.cancel),
            ),
          ),
        ],
      ),
    );
  }
}
