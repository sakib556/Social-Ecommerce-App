import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/themes/images.dart';
import 'package:protibeshi_app/views/auth/components/go_to_signup_text_button.dart';
import 'package:protibeshi_app/views/auth/components/or_continue_with.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';
import 'package:protibeshi_app/views/custom_widgets/text_with_button.dart';
import 'package:protibeshi_app/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:protibeshi_app/views/others/space_vertical.dart';

class PhoneNoLoginPage extends ConsumerWidget {
  final bool isFromSignup;
  const PhoneNoLoginPage({
    Key? key,
    this.isFromSignup = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
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
                      const LoginLogoAndTitle(),
                      const SpaceVertical(40),
                      const LoginForm(),
                      const SpaceVertical(48),
                      const OrContinueWith(),
                      const SpaceVertical(32),
                      isFromSignup
                          ? GoToSignUPTextButton(onPressed: () {
                              ref
                                  .watch(goToSignUpPageProvider.notifier)
                                  .goToSignUpPage(
                                      ref.watch(pageControllerProvider));
                            })
                          : Container(),
                      isFromSignup ? const SpaceVertical(24) : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneNoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //Obscure Texts
  bool _passwordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _phoneNoController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: "Phone Number",
              hintText: "01*********",
            ),
            validator: (value) {
              if (value != null && value.length == 11) {
                return null;
              } else {
                return "Invalid number";
              }
            },
          ),
          const SpaceVertical(24),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _passwordObscureText,
            decoration: InputDecoration(
              labelText: "Pasword",
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordObscureText = !_passwordObscureText;
                  });
                },
                icon: Icon(_passwordObscureText
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
            ),
            validator: (value) {
              if (value!.length < 6) {
                return "Password must be at least 6 characters";
              } else {
                return null;
              }
            },
          ),
          const SpaceVertical(8),
          Align(
              alignment: Alignment.centerRight,
              child: TextWithButton(
                onPressed: () {
                  // Get.to(() => ForgotPasswordPage(
                  //     authPageController: authPageController));
                },
                buttonText: "Forgot Password?",
              )),
          const SpaceVertical(32),
          rp.Consumer(builder: (context, ref, child) {
            return CustomButton(
              text: "Login",
              color: Theme.of(context).primaryColor,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // ref
                  //     .watch(signInWithEmailAndPasswordProvider.notifier)
                  //     .signInWithEmailAndPassword(context,
                  //         email: _phoneNoController.text.trim(),
                  //         password: _passwordController.text.trim());
                } else {
                  EasyLoading.showToast(
                    "Form is not yet validated!",
                    toastPosition: EasyLoadingToastPosition.bottom,
                  );
                }
              },
            );
          }),
          const SpaceVertical(8)
        ],
      ),
    );
  }
}

class LoginLogoAndTitle extends StatelessWidget {
  const LoginLogoAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpaceVertical(24),
        Hero(tag: "login_logo", child: Image.asset(MyImages.logo)),
        const SpaceVertical(16),
        Text(
          "Login",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
