import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final Color? color;
  final String text;
  final Widget? icon;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    this.color,
    required this.text,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: color == null
                ? Border.all( width: 2,color: Theme.of(context).colorScheme.onSurface.withOpacity(.38))
                : null,
          ),
          child: Row(
            children: [
              icon == null ? Container() : Expanded(flex: 1, child: icon!),
              Expanded(
                flex: 2,
                child: Text(
                  text,
                  textAlign: icon == null ? TextAlign.center : null,
                  style: Theme.of(context).textTheme.button
                ),
              ),
            ],
          )),
    );
  }
}
