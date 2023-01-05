import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String yesText;
  final String noText;
  final Function yesOnPressed;
  final Function noOnPressed;

  const CustomAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.yesText,
      required this.noText,
      required this.yesOnPressed,
      required this.noOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(title),
      content:  Text(content),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: <Widget>[
         ElevatedButton(
          child:  Text(yesText),
          onPressed: () {
           yesOnPressed();
          },
        ),
         ElevatedButton(
          child: Text(noText),
          onPressed: () {
            noOnPressed();
          },
        ),
      ],
    );
  }
}
