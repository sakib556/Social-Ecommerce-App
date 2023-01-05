import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:protibeshi_app/views/auth/components/accept_terms_and_conditions_text_button.dart';
import 'package:protibeshi_app/providers/auth_provider.dart';
import 'package:protibeshi_app/views/auth/continue_with_email/continue_with_email.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';

class SignUpMethods extends ConsumerWidget {
  const SignUpMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
       final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        CustomButton(
          text: "Continue With Phone",
          onPressed: () {
            //TODO: Continue with phone number
          },
          color: colorScheme.primary,
          icon: const Icon(
            Icons.phone,
          ),
        ),
        const SpaceVertical(16),
        CustomButton(
          text: "Continue With Facebook",
          onPressed: () async {
            await ref.watch(signInWithFacebookProvider.notifier).signInWithFacebook(context);
          },
          icon: const Icon(
            FontAwesomeIcons.facebook,
          ),
        ),
        const SpaceVertical(16),
        CustomButton(
          text: "Continue With Google",
          onPressed: () async {
            await ref.watch(signInWithGoogleProvider.notifier).signInWithGoogle(context);
          },
          icon: const Icon(
            FontAwesomeIcons.google,
          ),
        ),
        const SpaceVertical(16),
        CustomButton(
          text: "Continue with email",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ContinueWithEmailScreen(),
              ),
            );
          },
          icon: const Icon(
            CupertinoIcons.mail,
          ),
        ),
        const SpaceVertical(8),
        //Terms and conditions button
        const AcceptTermsAndConditionsTextButton(),
      ]          ,
    );
  }
}
