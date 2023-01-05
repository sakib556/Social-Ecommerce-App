import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SellRentBox extends StatefulWidget {
  SellRentBox({Key? key, required this.forRent}) : super(key: key);
  bool? forRent;

  @override
  State<SellRentBox> createState() => _ConditionBoxState();
}

class _ConditionBoxState extends State<SellRentBox> {
  int radioSelected = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Condition : ",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color:
                        Theme.of(context).colorScheme.onSurface.withOpacity(.7),
                  )),
          Row(
            children: [
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: radioSelected,
                    // activeColor: const Color.fromARGB(255, 7, 9, 10),
                    onChanged: (value) {
                      setState(() {
                        radioSelected = value as int;
                        widget.forRent = false;
                      });
                    },
                  ),
                  Text(conditionItem[0]),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: radioSelected,
                    // activeColor: const Color.fromARGB(255, 7, 9, 10),
                    onChanged: (value) {
                      setState(() {
                        radioSelected = value as int;
                        widget.forRent = true;
                      });
                    },
                  ),
                  Text(conditionItem[1]),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const List<String> conditionItem = ["Sell", "Rent"];

// class ConditionBoxModel {
//   int? radioSelected;
//   String radioVal;
//   List<String> conditionList;
//   ConditionBoxModel({
//     this.radioSelected,
//     required this.radioVal,
//     this.conditionList = conditionItem,
//   });
// }
