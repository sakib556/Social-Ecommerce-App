import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';

class CreateListingBudget extends StatefulWidget {
  final TextEditingController budgetController;
  final String title;

  const CreateListingBudget({
    Key? key,
    required this.budgetController, required this.title,
  }) : super(key: key);

  @override
  _CreateListingBudgetState createState() => _CreateListingBudgetState();
}

class _CreateListingBudgetState extends State<CreateListingBudget> {
  int _selectedBudget = 0;
  double _otherBudget = 0;

  final TextEditingController _otherBudgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.budgetController.text = _selectedBudget == -1
        ? _otherBudget.toString()
        : _defaultBudgets[_selectedBudget].toString();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SpaceVertical(16),
              Row(
                children: [
                  for (var item in _defaultBudgets)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedBudget = _defaultBudgets.indexOf(item);
                          _otherBudgetController.clear();
                          FocusScope.of(context).requestFocus(FocusNode());
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: _selectedBudget ==
                                      _defaultBudgets.indexOf(item)
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(.1)),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          item.toInt().toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: _selectedBudget ==
                                          _defaultBudgets.indexOf(item)
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(.4)),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: _otherBudgetController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(.1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(.1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Other",
                          hintStyle:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.4),
                                  )),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedBudget = -1;
                          if (value.isNotEmpty) {
                            _otherBudget = double.parse(value);
                          } else {
                            _otherBudget = 0;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SpaceVertical(5),

            ],
          ),
        ),
      ],
    );
  }
}

List<double> _defaultBudgets = [
  50,
  100,
  200,
];
