import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/models/user/verification_item_model.dart';
import 'package:protibeshi_app/providers/verification_provider.dart';
import 'package:protibeshi_app/themes/colors.dart';
import 'package:protibeshi_app/views/others/error_screen.dart';
import 'package:protibeshi_app/views/others/loading_screen.dart';
import 'package:protibeshi_app/views/tabs/profile/settings/verification/photo_id_page.dart';
import 'package:protibeshi_app/views/tabs/profile/settings/verification/selfie_page.dart';
import 'package:protibeshi_app/views/tabs/profile/settings/verification/utility_page.dart';

//Verification Satus 0 = pending , 1 = verified , 2 = rejected

class GetVerifiedPage extends ConsumerWidget {
  final bool _submitAgain = false;

  const GetVerifiedPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    final verify = ref.watch(verificationProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Verification'),
        ),
        body: verify.map(
            initial: (_) => const SizedBox(),
            loading: (_) => const LoadingScreen(),
            loaded: (_) {
              return _VerificationBuilder(verificationModel: _.data);
            },
            error: (_) => ErrorScreen(
                  errorMessage: _.error,
                )));
  }
}

class _VerificationBuilder extends StatefulWidget {
  final VerificationModel verificationModel;
  const _VerificationBuilder({
    Key? key,
    required this.verificationModel,
  }) : super(key: key);

  @override
  State<_VerificationBuilder> createState() => _VerificationBuilderState();
}

class _VerificationBuilderState extends State<_VerificationBuilder> {
  @override
  Widget build(BuildContext context) {
    VerificationItemModel? photoID = widget.verificationModel.photoID;
    VerificationItemModel? selfie = widget.verificationModel.selfie;
    VerificationItemModel? utility = widget.verificationModel.utility;
    return WillPopScope(
      onWillPop: () async {
        if (photoID == null && selfie == null && utility == null) {
          return await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure to discard verification?'),
                actions: [
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              );
            },
          );
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                (photoID == null || selfie == null || utility == null)
                    ? "Submit documents"
                    : "You Are Verified",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 8),
              Text(
                (photoID == null || selfie == null || utility == null)
                    ? "We need to verify your information.\n Please submit the documents below."
                    : "Thank you for verifying your information.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
              const SizedBox(height: 48),
              VerificationSingleStep(
                status: photoID?.status,
                leadingIcon: Icons.credit_card,
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PhotoIdPage(),
                    ),
                  );
                },
                title: "Photo ID",
              ),
              const SizedBox(height: 16),
              VerificationSingleStep(
                status: selfie?.status,
                leadingIcon: Icons.camera_alt,
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelfiePage(),
                    ),
                  );
                },
                title: "Selfie",
              ),
              const SizedBox(height: 16),
              VerificationSingleStep(
                status: utility?.status,
                leadingIcon: Icons.library_books,
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UtilityPage(),
                    ),
                  );
                },
                title: "Utility Bill/ Bank Statement",
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class VerificationSingleStep extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback onTap;
  final int? status;
  const VerificationSingleStep({
    Key? key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: MyColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.all(16),
      title: Text(title),
      leading: Icon(leadingIcon),
      trailing: CircleAvatar(
          backgroundColor: status == null
              ? MyColors.secondaryColor
              : status == 0
                  ? MyColors.goldColor
                  : status == 1
                      ? MyColors.greenColor
                      : status == 2
                          ? MyColors.redColor
                          : MyColors.secondaryColor,
          foregroundColor: MyColors.whiteColor,
          child: Icon(status == null
              ? Icons.arrow_forward
              : status == 0
                  ? Icons.warning
                  : status == 1
                      ? Icons.check
                      : status == 2
                          ? Icons.close
                          : Icons.arrow_forward)),
      onTap: () {
        if (status == null) {
          onTap();
        } else if (status == 0) {
          EasyLoading.showInfo("$title Pending Verfication");
        } else if (status == 1) {
          EasyLoading.showSuccess("$title Verified");
        } else if (status == 2) {
          EasyLoading.showError("$title Rejected");
        }
      },
    );
  }
}
