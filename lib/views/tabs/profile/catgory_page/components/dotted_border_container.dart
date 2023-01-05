import 'package:flutter/material.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_dotted_border.dart';

class DottedBorderContainer extends StatelessWidget {
  const DottedBorderContainer({
    required this.onPressed,
    Key? key,
    required this.width,
    required this.hasText,
    this.height,
  }) : super(key: key);
  final VoidCallback onPressed;
  final double width;
  final double? height;
  final bool hasText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          )),
      child: CustomDottedBorder(
          height: height ?? 200,
          iconSize: 60,
          hasText: hasText,
          onPressed: () {
            onPressed();
          }),
    );
  }
}
