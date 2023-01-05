import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/providers/auth_provider.dart';
import 'package:protibeshi_app/views/auth/continue_with_phone/phone_login_page.dart';
import 'package:protibeshi_app/views/auth/continue_with_phone/phone_sign_up_page.dart';

class ContinueWithPhoneScreen extends ConsumerWidget {
  const ContinueWithPhoneScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: ref.watch(pageControllerProvider),
        children: const [
          PhoneNoSignUpPage(),
          PhoneNoLoginPage(),
        ],
      )),
    );
  }
}




