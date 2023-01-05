import 'package:flutter/material.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';

class ConditionBox extends StatefulWidget {
  const ConditionBox({Key? key, required this.textController}) : super(key: key);
  final TextEditingController 
    textController ;

  @override
  State<ConditionBox> createState() => _ConditionBoxState();
}

class _ConditionBoxState extends State<ConditionBox> {
      int radioSelected=-1;
  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Condition : ",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(.7),
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
                          widget.textController.text = conditionItem[0];   
                          print(widget.textController.text);
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
                          widget.textController.text = conditionItem[1];   
                          print(widget.textController.text);
                        });
                      },
                    ),
                    Text(conditionItem[1]),
                  ],
                ),
              ],
            ),
            const SpaceVertical(5),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: radioSelected,
                      // activeColor: const Color.fromARGB(255, 7, 9, 10),
                      onChanged: (value) {
                        setState(() {
                             radioSelected = value as int;
                          widget.textController.text = conditionItem[2];   
                          print(widget.textController.text);
                        });
                      },
                    ),
                    Text(conditionItem[2]),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: radioSelected,
                      // activeColor: const Color.fromARGB(255, 7, 9, 10),
                      onChanged: (value) {
                        setState(() {
                              radioSelected = value as int;
                              print(radioSelected);
                          widget.textController.text = conditionItem[3];   
                          print(widget.textController.text);
                        });
                      },
                    ),
                    Text(conditionItem[3]),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
 
  }
}

const List<String> conditionItem = ["New", "Very good", "Okay", "Has issues"];

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
