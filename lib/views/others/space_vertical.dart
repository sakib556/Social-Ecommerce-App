
import 'package:flutter/cupertino.dart';

class SpaceVertical extends StatelessWidget {
  final double? height;
  const SpaceVertical(
    this.height,
    {Key? key,}
    ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height,);
  }
}