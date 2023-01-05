import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protibeshi_app/themes/colors.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/tabs/home/components/create_new_post_name_section.dart';
class CreateBorrowPost extends StatefulWidget {
  final VoidCallback onPressedNext;
  final VoidCallback onPressedBack;
  final TextEditingController postController;
  final List<File> selectedImages;
  final List<String> imgLink;
  final List<String> deleteImgLink;
  const CreateBorrowPost({
    Key? key,
    required this.onPressedNext,
    required this.onPressedBack,
    required this.postController,
    required this.selectedImages, required this.imgLink, required this.deleteImgLink,
  }) : super(key: key);
  @override
  _CreateBorrowPostState createState() => _CreateBorrowPostState();
}
class _CreateBorrowPostState extends State<CreateBorrowPost> {
  bool _bottomButtonVisible = true;
  bool _enableNextButton = false;
  double _postFontSize = 28;
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
    _enableNextButton = widget.postController.text.isNotEmpty;
print("${widget.imgLink.length} is length");
    return SafeArea(
      child: Scaffold(
        bottomSheet: _bottomButtonVisible
            ? CreateNewPostBottomButtons(
                onPressedOpenGallery: _onPressedGallery,
                onPressedOpenCamera: _onPressedCamera,
              )
            : CreatePostBottomButtonsBar(
                onPressedOpenCamera: _onPressedCamera,
                onPressedOpenGallery: _onPressedGallery,
                onPressedHideBottomButton: () {
                  setState(() {
                    _bottomButtonVisible = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
              ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _createNewPostTopBar(context),
                const SpaceVertical(16),
                const CretePostNameSection(),
                _createNewPostTextField(),
                _createNewPostImageSection(context),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createNewPostImageSection(BuildContext context) {
    return Column(
      children: [
      Wrap(
          children: widget.imgLink.map((e) {
            print("${widget.imgLink.length} is lengths");
            return SizedBox(
              width: widget.imgLink.length > 1
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.network(e, fit: BoxFit.cover),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.imgLink
                              .removeAt(widget.imgLink.indexOf(e));
                          widget.deleteImgLink.add(e);    
                        });
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      Wrap(
          children: widget.selectedImages.map((e) {
            return SizedBox(
              width: widget.selectedImages.length > 1
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width,
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
                        setState(() {
                          widget.selectedImages
                              .removeAt(widget.selectedImages.indexOf(e));
                        });
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
       ],
    );
  }

  Container _createNewPostTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 500),
          tween: Tween<double>(begin: _postFontSize, end: _postFontSize),
          builder: (context, double size, child) {
            return TextField(
              scrollPhysics: const BouncingScrollPhysics(),
              keyboardType: TextInputType.multiline,
              maxLines: 9,
              minLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(decoration: TextDecoration.none, fontSize: size),
              controller: widget.postController,
              onTap: () {
                setState(() {
                  _bottomButtonVisible = false;
                });
              },
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    _enableNextButton = true;
                  } else {
                    _enableNextButton = false;
                  }
                  if (value.length > 85) {
                    _postFontSize = 16;
                  } else {
                    _postFontSize = 28;
                  }
                });
              },
              decoration: InputDecoration(
                hintText: "I want to borrow a bicycle for 3 days",
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
                hintStyle: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
                    ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container _createNewPostTopBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButton(
            onPressed: () {
              _bottomButtonVisible = true;
              widget.onPressedBack();
            },
          ),
          Expanded(
              child: Text(
            'Create Post',
            style: Theme.of(context).textTheme.subtitle1,
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: ElevatedButton(
              onPressed: _enableNextButton
                  ? () {
                      widget.onPressedNext();
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  : null,
              child: const Text('NEXT'),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateNewPostBottomButtons extends StatelessWidget {
  final VoidCallback onPressedOpenGallery;
  final VoidCallback onPressedOpenCamera;
  const CreateNewPostBottomButtons({
    Key? key,
    required this.onPressedOpenGallery,
    required this.onPressedOpenCamera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text("Photo/Video"),
          onTap: onPressedOpenGallery,
          leading: const Icon(Icons.photo_library, color: MyColors.redColor),
        ),
        const Divider(),
        ListTile(
          title: const Text("Camera"),
          onTap: onPressedOpenCamera,
          leading:  Icon(Icons.camera_alt, color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }
}

class CreatePostBottomButtonsBar extends StatelessWidget {
  final VoidCallback onPressedHideBottomButton;
  final VoidCallback onPressedOpenGallery;
  final VoidCallback onPressedOpenCamera;
  const CreatePostBottomButtonsBar({
    Key? key,
    required this.onPressedHideBottomButton,
    required this.onPressedOpenGallery,
    required this.onPressedOpenCamera,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: onPressedOpenGallery,
                  icon: const Icon(
                    Icons.photo_library,
                    color: MyColors.redColor,
                  )),
              IconButton(
                  onPressed: onPressedOpenCamera,
                  icon:  Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              IconButton(
                  onPressed: onPressedHideBottomButton,
                  icon: const Icon(Icons.pending_rounded,
                                        )),
            ],
          ),
        ],
      ),
    );
  }
}
