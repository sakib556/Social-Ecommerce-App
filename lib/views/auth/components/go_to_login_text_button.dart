import 'package:flutter/material.dart';
import 'package:protibeshi_app/views/custom_widgets/text_with_button.dart';

class GoToLoginTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GoToLoginTextButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextWithButton(
      buttonText: "LOG IN",
      normalText: "Already have an account? ",
      onPressed: onPressed,
    );
  }
}
