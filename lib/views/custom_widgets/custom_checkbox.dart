

import 'package:flutter/material.dart';
class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({Key? key, required this.function, required this.isValue, required this.title}) : super(key: key);
  final void Function(bool value) function;
  final String title;
  final bool isValue;
  @override
  Widget build(BuildContext context) {
    return Expanded(
              child: CheckboxListTile(
                    title:  Text(title),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: isValue,
                    onChanged: (value){
                      function(value!);
                    },
                  )
                
              );
  }
}