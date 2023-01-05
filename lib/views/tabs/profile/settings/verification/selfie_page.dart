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

class SelfiePage extends StatefulWidget {
  final File? selfie;

  const SelfiePage({
    Key? key,
    this.selfie,
  }) : super(key: key);

  @override
  State<SelfiePage> createState() => _SelfiePageState();
}

class _SelfiePageState extends State<SelfiePage> {
  File? _selfie;

  final ImagePicker _picker = ImagePicker();

  void _onTapPicker() async {
    await _picker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        setState(() {
          _selfie = File(value.path);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _selfie = widget.selfie;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selfie'),
        leading: BackButton(
          onPressed: () {
            if (_selfie != null) {
              Navigator.pop(context, _selfie!);
            } else {
              Navigator.pop(context);
            }
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
              Text('Please take clear a selfie of your self',
                  style: Theme.of(context).textTheme.bodyText1),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: _onTapPicker,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: MyColors.blackColor.withOpacity(0.38)),
                  ),
                  child: _selfie == null
                      ? const Center(
                          child: Text('Take a selfie'),
                        )
                      : Image.file(
                          _selfie!,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              const Expanded(child: SizedBox(height: 32)),
              _selfie != null
                  ? Consumer(
                      builder: (context, ref, child) {
                        return ref
                            .watch(verificationSubmissionProvider(FirebaseVariables.selfie))
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
                                var selfieURL = await saveVPictures(_selfie!, FirebaseVariables.selfie);
                                
                                await ref
                                    .watch(verificationSubmissionProvider(
                                            FirebaseVariables.selfie)
                                        .notifier)
                                    .submitVerificationForm(
                                        VerificationItemModel(
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      itemOne: selfieURL!,
                                      
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
