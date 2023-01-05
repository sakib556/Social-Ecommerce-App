// import 'package:flutter/material.dart';
// import 'package:protibeshi_app/themes/colors.dart';

// class MyThemes {
//   //Light
//   static final light = ThemeData.light().copyWith(
//     // useMaterial3:true,
//     brightness: Brightness.light,
//     appBarTheme: const AppBarTheme().copyWith(
//       centerTitle: true,
//       elevation: 0,
//     ),
//     pageTransitionsTheme: const PageTransitionsTheme(
//       builders: {
//         TargetPlatform.android: CupertinoPageTransitionsBuilder(),
//       },
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: MyColors.whiteColor,
//       focusColor: MyColors.whiteColor,
//       hoverColor: MyColors.whiteColor,
//       border: UnderlineInputBorder(
//           borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
//       focusedBorder: UnderlineInputBorder(
//           borderSide: const BorderSide(
//             width: 1,
//             color: MyColors.primaryColor,
//           ),
//           borderRadius: BorderRadius.circular(10)),
//       errorBorder: UnderlineInputBorder(
//           borderSide: const BorderSide(width: 1, color: MyColors.errorColor),
//           borderRadius: BorderRadius.circular(10)),
//       focusedErrorBorder: UnderlineInputBorder(
//           borderSide: const BorderSide(width: 1, color: MyColors.errorColor),
//           borderRadius: BorderRadius.circular(10)),
//     ),
//     scaffoldBackgroundColor: MyColors.lightThemeBackground,
//     cardTheme: CardTheme(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//     colorScheme: const ColorScheme.light().copyWith(
//       primaryVariant: MyColors.primaryColor,
//       surface: MyColors.primaryColor,
//       primary: MyColors.primaryColor,
//       onPrimary: MyColors.onPrimary,
//       secondary: MyColors.primaryColor,
//       onSecondary: MyColors.onPrimary,
//     ),
//   );

//   //Dark
//   static final dark = ThemeData.dark().copyWith(
//     appBarTheme: const AppBarTheme().copyWith(
//       centerTitle: true,
//       elevation: 0,
//     ),
//     pageTransitionsTheme: const PageTransitionsTheme(
//       builders: {
//         TargetPlatform.android: CupertinoPageTransitionsBuilder(),
//       },
//     ),
//     colorScheme: const ColorScheme.light().copyWith(
//       primaryVariant: MyColors.primaryColor,
//       surface: MyColors.primaryColor,
//       primary: MyColors.primaryColor,
//       onPrimary: MyColors.onPrimary,
//       secondary: MyColors.primaryColor,
//       onSecondary: MyColors.onPrimary,
//     ),
//   );

//     //Light2 new 
//   static final light2 = ThemeData.light().copyWith(
//     useMaterial3:true,
//     brightness: Brightness.light,
//     appBarTheme: const AppBarTheme().copyWith(
//       centerTitle: true,
//       elevation: 0,
//       backgroundColor: primaryColor
//     ),
//     pageTransitionsTheme: const PageTransitionsTheme(
//       builders: {
//         TargetPlatform.android: CupertinoPageTransitionsBuilder(),
//       },
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: MyColors.whiteColor,
//       focusColor: MyColors.whiteColor,
//       hoverColor: MyColors.whiteColor,
//       border: UnderlineInputBorder(
//           borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
//       focusedBorder: UnderlineInputBorder(
//           borderSide: const BorderSide(
//             width: 1,
//             color: MyColors.primaryColor,
//           ),
//           borderRadius: BorderRadius.circular(10)),
//       errorBorder: UnderlineInputBorder(
//           borderSide: const BorderSide(width: 1, color: MyColors.errorColor),
//           borderRadius: BorderRadius.circular(10)),
//       focusedErrorBorder: UnderlineInputBorder(
//           borderSide: const BorderSide(width: 1, color: MyColors.errorColor),
//           borderRadius: BorderRadius.circular(10)),
//     ),
//     scaffoldBackgroundColor: MyColors.lightThemeBackground,
//     cardTheme: CardTheme(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//     colorScheme: const ColorScheme.light().copyWith(
//       primaryVariant: MyColors.primaryColor,
//       surface: MyColors.primaryColor,
//       primary: MyColors.primaryColor,
//       onPrimary: MyColors.onPrimary,
//       secondary: MyColors.primaryColor,
//       onSecondary: MyColors.onPrimary,
//     ),
//   );

//   //Dark2 new
//   static final dark2 = ThemeData(
//     useMaterial3:true,
//     appBarTheme: const AppBarTheme().copyWith(
//       centerTitle: true,
//       elevation: 0,
//     ),
//     pageTransitionsTheme: const PageTransitionsTheme(
//       builders: {
//         TargetPlatform.android: CupertinoPageTransitionsBuilder(),
//       },
//     ),
//     colorScheme: const ColorScheme.light().copyWith(
//       brightness: Brightness.dark,
//       primaryVariant: MyColors.primaryColor,
//       surface: MyColors.blackColor,
//       primary: MyColors.primaryColor,
//       onPrimary: MyColors.onPrimary,
//       secondary: MyColors.primaryColor,
//       onSecondary: MyColors.whiteColor,
//       primaryContainer: MyColors.blackColor,
//       outline:  Colors.white
//     ),
//   );

// }
