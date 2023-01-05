import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:protibeshi_app/providers/auth_provider.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';

class OrContinueWith extends ConsumerWidget {
  const OrContinueWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Column(
      children: [
        const Text("or continue with"),
        const SpaceVertical(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                //TODO: continue with phone
              },
              icon: const Icon(
                Icons.phone,
              ),
            ),
            IconButton(
              onPressed: () async {
                await ref.watch(signInWithFacebookProvider.notifier)
                          .signInWithFacebook(context,willGoBack: true);
              },
              icon: const Icon(
                FontAwesomeIcons.facebook,
              ),
            ),
            IconButton(
              onPressed: () async {
                 await ref.watch(signInWithGoogleProvider.notifier)
                          .signInWithGoogle(context,willGoBack: true);
              },
              icon: const Icon(
                FontAwesomeIcons.google,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
