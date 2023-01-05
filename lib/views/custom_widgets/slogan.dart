import 'package:flutter/material.dart';

class Slogan extends StatelessWidget {
  final TextAlign textAlign;

  const Slogan({
    Key? key,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "সেবা দিন\nসেবা নিন\nপ্রতিবেশী থেকেই",
      textAlign: textAlign,
      style: Theme.of(context).textTheme.headline5!.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(.50)
          ),
    );
  }
}
