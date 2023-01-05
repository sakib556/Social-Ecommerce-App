import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';

class PriceTextBox extends StatefulWidget {
  const PriceTextBox(
      {Key? key,
      required this.budgetController,
      required this.hint,
      required this.title})
      : super(key: key);
  final TextEditingController budgetController;
  final String hint;
  final String title;
  @override
  State<PriceTextBox> createState() => _PriceTextBoxState();
}

class _PriceTextBoxState extends State<PriceTextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headline6,
                        ),
              SizedBox(
                width: 100,
                child: TextField(
                  // controller: widget.budgetController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.onSurface.withOpacity(.1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.onSurface.withOpacity(.1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: widget.hint,
                      hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(.4),
                          )),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                  ],
                  onChanged: (value) {
                    setState(() {
                      widget.budgetController.text = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SpaceVertical(5),
        ],
      ),
    );
  }
}
