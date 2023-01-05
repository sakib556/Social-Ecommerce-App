import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ErrorScreen extends StatelessWidget {
  ErrorScreen({Key? key, this.errorMessage}) : super(key: key);
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(errorMessage ?? "Error!"),
      ),
    );
  }
}
