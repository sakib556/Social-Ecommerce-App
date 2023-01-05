import 'package:flutter/material.dart';

class MyColors {
  MyColors._();
  static const lightThemeBackground = Color(0xfff6f6f6);
  static const primaryColor = Color(0xff1dbf73);
  static const onPrimary = Color(0xffe8e8e8);

  static const secondaryColor = Color(0xff6b6b6b);

  static const errorColor = Color(0xFF9C0000);

  //Custom Colors
  static const facebookColor = Color(0xff4267b2);
  static const whiteColor = Colors.white;
  static const blackColor = Colors.black;
  static const goldColor = Color(0xffEEB403);
  static const greenColor = Color(0xff2CA14C);
  static const redColor = Color(0xFFEE0606);
  static const yelloColor = Color(0xFFBB980A);

  static const lightBgColor = Color(0xFFEBEBEB);

  static const underLineColor = Color(0xffACACAC);

  static const verifiedColor = Color(0xff2CA14C);

  static const priceColor = Color(0xffE98F1A);


}

const primaryColor =  Color(0xff0D6D35);
final primarySwatch = MaterialColor(primaryColor.value, _swatch);
final _swatch = {
  0:  Colors.black,
  10: primaryColor.withOpacity(1),
  20: primaryColor.withOpacity(0.9),
  30: primaryColor.withOpacity(0.8),
  40: primaryColor.withOpacity(0.7),
  50: primaryColor.withOpacity(0.6),
  60: primaryColor.withOpacity(0.5),
  70: primaryColor.withOpacity(0.4),
  80: primaryColor.withOpacity(0.3),
  90: primaryColor.withOpacity(0.2),
  95: primaryColor.withOpacity(0.15),
  99: primaryColor.withOpacity(0.11),
  100:primaryColor.withOpacity(.1),
};
final _swatchold = {
  0:  const Color(0xff000000),
  10: const Color(0xff00210B),
  20: const Color(0xff003918),
  30: const Color(0xff005225),
  40: const Color(0xff0D6D35),
  50: const Color(0xff31874C),
  60: const Color(0xff4DA163),
  70: const Color(0xff68BD7C),
  80: const Color(0xff83D995),
  90: const Color(0xff9EF6AF),
  95: const Color(0xffC4FFCC),
  99: const Color(0xffF5FFF2),
  100: const Color(0xffFFFFFF),
};