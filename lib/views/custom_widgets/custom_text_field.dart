import 'package:flutter/material.dart';

class TextFieldWithHeading extends StatelessWidget {
  final String? heading;
  final int maxLines;
  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const TextFieldWithHeading({
    Key? key,
     this.heading,
    required this.maxLines,
    required this.hintText,
    required this.controller,
    this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading != null
            ? Text(heading!,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(.7),
                    ))
            : const SizedBox(),
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: maxLines > 2 ? 60 : 52,
          child: TextField(
            controller: controller,
            onChanged: (value) => onChanged,
            maxLines: maxLines,
            style: TextStyle(
              fontSize: 16,
              height: 2.0,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(.6),
            ),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(16, 5, 0, 5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).colorScheme.onSurface.withOpacity(.4),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).colorScheme.onSurface.withOpacity(.4),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(.4),
                    )),
          ),
        )
      ],
    );
  }
}
