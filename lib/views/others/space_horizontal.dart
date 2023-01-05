
import 'package:flutter/cupertino.dart';

class SpaceHorizontal extends StatelessWidget {
  final double? width;
  const SpaceHorizontal(
    this.width,
   {Key? key,}
    ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width,);
  }
}