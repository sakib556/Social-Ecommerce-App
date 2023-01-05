import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  final String? errorMessage;
  const SomethingWentWrong({
    Key? key,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
            child: Text(errorMessage ?? 'Something went wrong!'),
      ),
    );
  }
}
