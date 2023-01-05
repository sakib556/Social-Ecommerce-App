import 'package:flutter/material.dart';

class ColourButton extends StatefulWidget {
  const ColourButton(
      {Key? key,
      required this.selectedIndex,
      required this.title,
      required this.constIndex,
      required this.backgroundColor,
      required this.borderColor,
      required this.titleColor,
      required this.onPressed})
      : super(key: key);
  final int selectedIndex;
  final String title;
  final int constIndex;
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final void Function() onPressed;

  @override
  State<ColourButton> createState() => _ColourButtonState();
}

class _ColourButtonState extends State<ColourButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          side: BorderSide(width: 1.0, color: widget.borderColor),
        ),
        child: Text(widget.title, style: TextStyle(color: widget.titleColor)),
        onPressed: () {
          setState(() {
          widget.onPressed();
          });
        },
      ),
    );
  }
}
