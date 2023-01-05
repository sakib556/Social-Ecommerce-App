// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:protibeshi_app/themes/colors.dart';
// import 'package:protibeshi_app/themes/images.dart';
// import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';
// import 'package:protibeshi_app/controllers/auth_controller/auth_controller.dart';
// import 'package:responsive_builder/responsive_builder.dart';

// class ForgotPasswordPage extends StatelessWidget {
//   final AuthController authPageController;

//   const ForgotPasswordPage({
//     Key? key,
//     required this.authPageController,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ScreenTypeLayout(
//         mobile: MobileViewForgotPasswordPage(
//           authPageController: authPageController,
//         ),
//         desktop: DesktopViewForgotPasswordPage(
//           authPageController: authPageController,
//         ),
//         tablet: DesktopViewForgotPasswordPage(
//           authPageController: authPageController,
//         ),
//       ),
//     );
//   }
// }

// class DesktopViewForgotPasswordPage extends StatelessWidget {
//   const DesktopViewForgotPasswordPage({
//     Key? key,
//     required this.authPageController,
//   }) : super(key: key);

//   final AuthController authPageController;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: 500,
//         padding: EdgeInsets.symmetric(vertical: 32),
//         child: MobileViewForgotPasswordPage(
//           authPageController: authPageController,
//         ),
//       ),
//     );
//   }
// }

// class MobileViewForgotPasswordPage extends StatelessWidget {
//   const MobileViewForgotPasswordPage({
//     Key? key,
//     required this.authPageController,
//   }) : super(key: key);

//   final AuthController authPageController;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   ForgotPasswordLogoAndTitle(),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Form(
//                     key: authPageController.resetPassFormKey,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           controller:
//                               authPageController.resetPasswordEmailController,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             labelText: "Email",
//                             hintText: "example@email.com",
//                             prefixIcon: Icon(
//                               CupertinoIcons.mail,
//                             ),
//                           ),
//                           validator: (value) {
//                             if (!GetUtils.isEmail(value!)) {
//                               return "Invalid Email";
//                             } else
//                               return null;
//                           },
//                         ),
//                         SizedBox(height: 32),
//                         CustomButton(
//                           text: "Send reset request",
//                           color: MyColors.primaryColor,
//                           onPressed: authPageController.onPressedResetPassword,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 48),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ForgotPasswordLogoAndTitle extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: 24,
//         ),
//         Hero(tag: "login_logo", child: Image.asset(MyImages.logo)),
//         SizedBox(
//           height: 16,
//         ),
//         Text(
//           "Reset Password",
//           style: Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }
// }
