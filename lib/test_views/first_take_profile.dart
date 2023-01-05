// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:protibeshi_app/models/user/profile_picture_model.dart';
// import 'package:protibeshi_app/providers/user_provider.dart';
// import 'package:protibeshi_app/themes/colors.dart';
// import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';
// import 'package:protibeshi_app/views/custom_widgets/user_basic_builder.dart';
// import 'package:protibeshi_app/views/tabs/bottom_nav_bar_page.dart';
// import 'package:protibeshi_app/views/tabs/home/map_page.dart';
// import 'package:protibeshi_app/views/tabs/profile/settings/save_home_address.dart';
// import 'package:provider/provider.dart';

// class FirstTakeProfileInfoOld extends StatefulWidget {
//   const FirstTakeProfileInfoOld({Key? key}) : super(key: key);

//   @override
//   State<FirstTakeProfileInfoOld> createState() => _FirstTakeProfileInfoOldState();
// }

// class _FirstTakeProfileInfoOldState extends State<FirstTakeProfileInfoOld> {
//   final TextEditingController _nameController = TextEditingController();
//   String _house = "";
//   String _street = "";
//   String _area = "";
//   final _pageController = PageController();
//   @override
//   Widget build(BuildContext context) {
//     final _userProvider = Provider.of<UserProvider>(context, listen: false);

//     return Scaffold(
//       body: SafeArea(
//         child: PageView(
//           physics: const NeverScrollableScrollPhysics(),
//           controller: _pageController,
//           children: [
//             _firstPage(context, _userProvider),
//             _secondPage(),
//             _thirdPage(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _thirdPage() {
//     return MapPage(
//       fromFirstPage: true,
//       locationType: 1,
//       area: _area,
//       house: _house,
//       street: _street,
//     );
//   }

//   Widget _secondPage() {
//     return SaveHomeAddress(
//       onSave: (house, street, area) {
//         setState(() {
//           _house = house;
//           _street = street;
//           _area = area;
//         });

//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text("Are you currently in this location?"),
//             actions: [
//               TextButton(
//                   onPressed: () async {
//                     Navigator.of(context).pop();
//                     await Provider.of<UserProvider>(context, listen: false)
//                         .saveCurrentPosition(
//                       area: area,
//                       house: house,
//                       street: street,
//                       locationType: 1,
//                     );
//                     EasyLoading.showSuccess("Saved!");

//                     Provider.of<UserProvider>(context, listen: false)
//                         .updateProfileFirstTime();

//                     Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const BottomNavBarPage(),
//                         ),
//                         (route) => false);
//                   },
//                   child: const Text("No")),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     _pageController.nextPage(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeIn,
//                     );
//                   },
//                   child: const Text("Yes")),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Column _firstPage(BuildContext context, UserProvider _userProvider) {
//     return Column(
//       children: [
//         Expanded(
//           child: SingleChildScrollView(
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 64),
//                   Text(
//                     'Basic Info',
//                     style: Theme.of(context).textTheme.headline5,
//                   ),
//                   const SizedBox(height: 64),
//                   StreamBuilder<List<ProfilePictureModel>>(
//                       stream: _userProvider.userProfilePictures(
//                           uid: FirebaseAuth.instance.currentUser!.uid),
//                       builder: (context, profileSnapshot) {
//                         return profileSnapshot.hasError
//                             ? Container()
//                             : profileSnapshot.hasData
//                                 ? GestureDetector(
//                                     onTap: () async {
//                                       await Provider.of<UserProvider>(context,
//                                               listen: false)
//                                           .updateUserProfilePic(profileSnapshot
//                                                   .data!.isEmpty
//                                               ? 0
//                                               : profileSnapshot.data!.length);
//                                     },
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(400),
//                                         clipBehavior: Clip.hardEdge,
//                                         child: Container(
//                                           width: 150,
//                                           height: 150,
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(400),
//                                               border: Border.all(
//                                                 color: MyColors.secondaryColor
//                                                     .withOpacity(0.38),
//                                               )),
//                                           child: profileSnapshot.data!.isEmpty
//                                               ? Icon(
//                                                   Icons.camera_alt,
//                                                   color: MyColors.blackColor
//                                                       .withOpacity(0.38),
//                                                   size: 32,
//                                                 )
//                                               : CachedNetworkImage(
//                                                   imageUrl: profileSnapshot
//                                                       .data!.first.imageUrl,
//                                                   width: 80,
//                                                   height: 80,
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 : Container();
//                       }),
//                   const SizedBox(height: 16),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Add a profile picture',
//                       style: Theme.of(context).textTheme.caption,
//                     ),
//                   ),
//                   const SizedBox(height: 64),
//                   UserBasicBuilder(builder: (context, user, isOnline) {
//                     _nameController.text = user.name ?? '';
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextFormField(
//                           keyboardType: TextInputType.name,
//                           controller: _nameController,
//                           decoration: const InputDecoration(
//                             labelText: "What should we call you?",
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 4),
//                           child: Text(
//                             "Nickname",
//                             style: Theme.of(context).textTheme.caption,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 48,
//                         ),
//                       ],
//                     );
//                   })
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: CustomButton(
//             text: "Next",
//             onPressed: () {
//               if (_nameController.text.isEmpty) {
//                 EasyLoading.showInfo(
//                   "Please enter your name",
//                 );
//               } else {
//                 _userProvider.updateName(_nameController.text.trim(),
//                     showToast: false);
//                 _nameController.clear();
//                 _pageController.nextPage(
//                   duration: const Duration(milliseconds: 300),
//                   curve: Curves.easeIn,
//                 );

//                 FocusScope.of(context).requestFocus(FocusNode());
//               }
//             },
//             color: MyColors.primaryColor,
//           ),
//         )
//       ],
//     );
//   }
// }
