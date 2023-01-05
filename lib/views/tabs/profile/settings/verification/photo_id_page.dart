import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/picture_upload.dart';
import 'package:protibeshi_app/models/user/verification_item_model.dart';
import 'package:protibeshi_app/providers/verification_provider.dart';
import 'package:protibeshi_app/themes/colors.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';

class PhotoIdPage extends StatefulWidget {
  final File? frontView;
  final File? backView;
  const PhotoIdPage({
    Key? key,
    this.frontView,
    this.backView,
  }) : super(key: key);

  @override
  State<PhotoIdPage> createState() => _PhotoIdPageState();
}

class _PhotoIdPageState extends State<PhotoIdPage> {
  File? _photoIdFrontView;
  File? _photoIdBackView;

  final ImagePicker _picker = ImagePicker();

  void _onTapPicker(int index) async {
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        setState(() {
          if (index == 0) {
            _photoIdFrontView = File(value.path);
          } else {
            _photoIdBackView = File(value.path);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _photoIdFrontView = widget.frontView;
    _photoIdBackView = widget.backView;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo ID'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text('Please take photos of front and back of your of your ID',
                  style: Theme.of(context).textTheme.bodyText1),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  _onTapPicker(0);
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: MyColors.blackColor.withOpacity(0.38)),
                  ),
                  child: _photoIdFrontView == null
                      ? const Center(
                          child: Text('Front View'),
                        )
                      : Image.file(
                          _photoIdFrontView!,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  _onTapPicker(1);
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: MyColors.blackColor.withOpacity(0.38)),
                  ),
                  child: _photoIdBackView == null
                      ? const Center(
                          child: Text('Back View'),
                        )
                      : Image.file(
                          _photoIdBackView!,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              const Expanded(child: SizedBox(height: 32)),
              _photoIdBackView != null && _photoIdFrontView != null
                  ? Consumer(
                      builder: (context, ref, child) {
                        return ref
                            .watch(verificationSubmissionProvider(
                                FirebaseVariables.photoID))
                            .maybeWhen(
                          orElse: () {
                            return CustomButton(
                              text: "Save",
                              onPressed: () async {},
                              color: MyColors.primaryColor,
                            );
                          },
                          error: (_) {
                            return CustomButton(
                              text: _,
                              onPressed: () async {},
                              color: MyColors.primaryColor,
                            );
                          },
                          initial: () {
                            return CustomButton(
                              text: "Save",
                              onPressed: () async {
                                EasyLoading.showInfo("Uploading..");
                                var frontURL = await saveVPictures(
                                    _photoIdFrontView!, "photoIdFront");
                                var backURL = await saveVPictures(
                                    _photoIdFrontView!, "photoIdFront");
                                await ref
                                    .watch(verificationSubmissionProvider(
                                            FirebaseVariables.photoID)
                                        .notifier)
                                    .submitVerificationForm(
                                        VerificationItemModel(
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      itemOne: frontURL!,
                                      itemTwo: backURL!,
                                      status: 0, //Verification Satus 0 = pending , 1 = verified , 2 = rejected
                                      statusMessage: "Pending Verification",
                                    ));
                                Navigator.pop(
                                  context,
                                );
                              },
                              color: MyColors.primaryColor,
                            );
                          },
                        );
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
