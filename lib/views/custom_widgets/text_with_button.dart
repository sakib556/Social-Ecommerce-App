import 'package:flutter/material.dart';

class TextWithButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? normalText;
  final String buttonText;
  const TextWithButton({
    Key? key,
    required this.onPressed,
    this.normalText,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: normalText),
            TextSpan(
              text: buttonText,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
