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

class UtilityPage extends StatefulWidget {
  final File? utility;

  const UtilityPage({
    Key? key,
    this.utility,
  }) : super(key: key);

  @override
  State<UtilityPage> createState() => _UtilityPageState();
}

class _UtilityPageState extends State<UtilityPage> {
  File? _utility;

  final ImagePicker _picker = ImagePicker();

  void _onTapPicker() async {
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        setState(() {
          _utility = File(value.path);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _utility = widget.utility;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Utility'),
        leading: BackButton(
          onPressed: () {
            if (_utility != null) {
              Navigator.pop(context, _utility!);
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
              Text(
                  'Please take picture of Utility Bill/ Bank Statement or any other which has your home location. Take a clear picture!',
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
                  child: _utility == null
                      ? const Center(
                          child: Text('Take a utility'),
                        )
                      : Image.file(
                          _utility!,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              const Expanded(child: SizedBox(height: 32)),
              _utility != null
                  ? Consumer(
                      builder: (context, ref, child) {
                        return ref
                            .watch(verificationSubmissionProvider(
                                FirebaseVariables.utility))
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
                                var utilityURL = await saveVPictures(
                                    _utility!, FirebaseVariables.utility);

                                await ref
                                    .watch(verificationSubmissionProvider(
                                            FirebaseVariables.utility)
                                        .notifier)
                                    .submitVerificationForm(
                                        VerificationItemModel(
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      itemOne: utilityURL!,
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
