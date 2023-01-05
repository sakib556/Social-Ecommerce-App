import 'package:flutter/material.dart';

class CategoryName extends StatelessWidget {
  final String name;
  const CategoryName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.w500),
        textAlign: TextAlign.start,
      ),
    );
  }
}
