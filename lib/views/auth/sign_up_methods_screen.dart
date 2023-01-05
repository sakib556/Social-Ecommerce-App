import 'package:flutter/material.dart';
import 'package:protibeshi_app/views/auth/components/go_to_login_text_button.dart';
import 'package:protibeshi_app/views/auth/components/logo_and_slogan.dart';
import 'package:protibeshi_app/views/auth/components/sign_up_methods.dart';
import 'package:protibeshi_app/views/auth/continue_with_email/login_page.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';

class SignUpMethodsScreen extends StatelessWidget {
  const SignUpMethodsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const LogoAndSlogan(),
                        const SpaceVertical(64),
                        const SignUpMethods(),
                        const SpaceVertical(64),
                        GoToLoginTextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(
                                  isFromSignup: false,
                                ),
                              ),
                            );
                          },
                        ),
                        const SpaceVertical(24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
