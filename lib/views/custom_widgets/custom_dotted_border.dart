import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';

class CustomDottedBorder extends StatelessWidget {
  final double iconSize;    
  final bool hasText;
  final VoidCallback onPressed;
  final double? height;
  const CustomDottedBorder({
    Key? key,
    required this.iconSize, //60 40
    required this.hasText,
    required this.onPressed, this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: DottedBorder(
                          borderType: BorderType.RRect,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.30),
                          dashPattern: const [6, 3, 6, 3],
                          radius: const Radius.circular(12),
                          child: SizedBox(
                            height: height ?? 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                   Icon(
                                    Icons.add_circle_outline,
                                    size: iconSize,
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.40),
                                  ),
                                  hasText? const SpaceVertical(16) : const SizedBox(),
                                  hasText
                                  ? Text(
                                    "Upload 3 Images",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.40),
                                            ),
                                   )
                                  : const SizedBox(), 
                                ],
                              ),
                            ),
                          ),
                        ),
    );
  }
}