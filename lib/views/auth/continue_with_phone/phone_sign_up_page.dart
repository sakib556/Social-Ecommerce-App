import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:protibeshi_app/views/auth/components/accept_terms_and_conditions_text_button.dart';
import 'package:protibeshi_app/providers/auth_provider.dart';
import 'package:protibeshi_app/themes/images.dart';
import 'package:protibeshi_app/views/auth/components/go_to_login_text_button.dart';
import 'package:protibeshi_app/views/auth/components/or_continue_with.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:protibeshi_app/views/others/space_vertical.dart';

class PhoneNoSignUpPage extends StatelessWidget {
  const PhoneNoSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      const SignUpLogoAndTitle(),
                      const SpaceVertical(40),
                      const SignUpForm(),
                      const SpaceVertical(48),
                      const OrContinueWith(),
                      const SpaceVertical(16),
                      rp.Consumer(builder: (context, ref, child) {
                        return GoToLoginTextButton(onPressed: () {
                          ref
                              .watch(goToLoginPageProvider.notifier)
                              .goToLoginPage(ref.watch(pageControllerProvider));
                        });
                      }),
                      const SpaceVertical(24),
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

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _phoneNoController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  //Obscure Texts
  bool _passwordObscureText = true;
  bool _confirmPasswordObscureText = true;
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
              if (value!=null && value.length == 11) {
                return null;
              } else {
                return "Invalid number";
              }
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _passwordObscureText,
            decoration: InputDecoration(
              labelText: "Password",
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
                return "Password must be at least 6 characters long!";
              } else {
                return null;
              }
            },
          ),
          const SpaceVertical(24),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _confirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _confirmPasswordObscureText,
            decoration: InputDecoration(
              labelText: "Confirm Password",
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _confirmPasswordObscureText = !_confirmPasswordObscureText;
                  });
                },
                icon: Icon(_confirmPasswordObscureText
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
            ),
            validator: (value) {
              if (value!.length < 6) {
                return "Password must be at least 6 characters long!";
              } else if (_passwordController.text !=
                  _confirmPasswordController.text) {
                return "Passwords don't match!";
              } else {
                return null;
              }
            },
          ),
          const SpaceVertical(32),
          rp.Consumer(builder: (context, ref, child) {
            return CustomButton(
              text: "Sign UP",
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // ref
                  //     .watch(signUpWithEmailAndPasswordProvider.notifier)
                  //     .signUpWithEmailAndPassword(context,
                  //         email: _emailController.text.trim(),
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
          const SpaceVertical(8),
          const AcceptTermsAndConditionsTextButton(),
        ],
      ),
    );
  }
}

class SignUpLogoAndTitle extends StatelessWidget {
  const SignUpLogoAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpaceVertical(24),
        Hero(tag: "logo", child: Image.asset(MyImages.logo)),
        const SpaceVertical(16),
        Text(
          "Sign UP",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
