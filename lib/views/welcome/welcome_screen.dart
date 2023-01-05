// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:protibeshi_app/themes/images.dart';
// import 'package:get/get.dart';
// import 'package:protibeshi_app/views/custom_widgets/slogan.dart';
// import 'package:protibeshi_app/controllers/onboarding_controller/onboarding_controller.dart';

// class WelcomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     OnBoardingController _onBoardingController =
//         Get.put(OnBoardingController());

//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _onBoardingController.goToAuthPage();
//         },
//         child: Icon(CupertinoIcons.chevron_forward),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Image.asset(MyImages.welcome_thumb),
//               Slogan(
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
