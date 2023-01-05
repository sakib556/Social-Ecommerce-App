import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:protibeshi_app/themes/images.dart';
import 'package:protibeshi_app/views/custom_widgets/slogan.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';

class LogoAndSlogan extends StatelessWidget {
  const LogoAndSlogan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpaceVertical(32),
        Hero(tag: "logo", child: Image.asset(MyImages.logo)),
        const SpaceVertical(32),
        const Slogan(),
      ],
    );
  }
}
