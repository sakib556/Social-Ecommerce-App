import 'package:flutter/material.dart';
import 'package:protibeshi_app/views/custom_widgets/text_with_button.dart';

class GoToSignUPTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GoToSignUPTextButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextWithButton(
      buttonText: "SIGN UP",
      normalText: "Don't have an account? ",
      onPressed: onPressed,
    );
  }
}
