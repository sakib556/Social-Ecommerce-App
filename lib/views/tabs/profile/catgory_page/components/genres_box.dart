import 'package:flutter/material.dart';

class GenresBox extends StatelessWidget {
  const GenresBox({Key? key, required this.onTap, required this.title}) : super(key: key);
  final void Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  height: 2.0,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                ),
              ),
              Icon(
                Icons.keyboard_double_arrow_down,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(.6),
              )
            ],
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(.4),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }
}
