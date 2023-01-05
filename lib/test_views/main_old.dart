// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
// import 'package:protibeshi_app/helper/config_loading.dart';
// import 'package:protibeshi_app/providers/auth_provider.dart';
// import 'package:protibeshi_app/providers/theme_provider.dart';
// import 'package:protibeshi_app/providers/user_provider.dart';
// import 'package:protibeshi_app/themes/colors.dart';
// import 'package:protibeshi_app/translations/codegen_loader.g.dart';
// import 'package:protibeshi_app/views/auth/first_take_profile.dart';
// import 'package:protibeshi_app/views/auth/sign_up_methods_screen.dart';
// import 'package:protibeshi_app/views/custom_widgets/user_basic_builder.dart';
// import 'package:protibeshi_app/views/other_pages/loading.dart';
// import 'package:protibeshi_app/views/other_pages/something_went_wrong.dart';
// import 'package:protibeshi_app/views/tabs/bottom_nav_bar_page.dart';
// import 'package:provider/provider.dart';

// Future<void> _handleBackgroundNotification(RemoteMessage message) async {
//   await Firebase.initializeApp();

//   print(message.notification!.title);
//   print(message.notification!.body);

//   //TODO: handle Notification
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(_handleBackgroundNotification);
//   await EasyLocalization.ensureInitialized();
//   runApp( EasyLocalization(
//       supportedLocales: [ Locale('en'), Locale('bn')],
//       path: 'assets/translations', 
//       fallbackLocale: const Locale('en'),
//       assetLoader: const CodegenLoader(),
//       child: const rp.ProviderScope(child: MainApp())
//     ),);
//   configLoading();
// }

// class MainApp extends StatelessWidget {
//   const MainApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations(
//         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//     return MultiProvider(
//         providers: [
//            ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
//         ],
//         child: rp.Consumer(
//           builder: ((context, ref, child) {
//             final isDark = ref.watch(themeProvider);

//             return MaterialApp(
//               localizationsDelegates: context.localizationDelegates,
//               supportedLocales: context.supportedLocales,
//               locale: context.locale,
//               title: 'Protibeshi',
//               debugShowCheckedModeBanner: false,
//               themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
//               theme: ThemeData(
//                   useMaterial3: true,
//                   primarySwatch: _primarySwatch,
//                   appBarTheme:
//                       const AppBarTheme(backgroundColor: Colors.white)),
//               darkTheme: ThemeData(
//                 useMaterial3: true,
//                 brightness: Brightness.dark,
//                 primarySwatch: _primarySwatch,
//               ),
//               home: const LandingPage(),
//               builder: EasyLoading.init(),
//             );
//           }),
//         ));
//   }
// }
// class LandingPage extends StatelessWidget {
//   const LandingPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final _authProvider = Provider.of<AuthProvider>(context, listen: false);
//     return Scaffold(
//       body: SafeArea(
//         child: StreamBuilder<User?>(
//             stream: _authProvider.authStateChanges,
//             builder: (context, snapshot) {
//               return snapshot.hasError
//                   ? const SomethingWentWrong()
//                   : snapshot.connectionState == ConnectionState.active  
//                           ? snapshot.hasData
//                              ? UserBasicBuilder(
//                               builder: (context, userBasicModel, isOnline) {
//                                 return userBasicModel.isProfileSaved
//                                     ? const BottomNavBarPage()
//                                     : const FirstTakeProfileInfo();
//                               },)
//                              : const SignUpMethodsScreen()
//                           : const Loading();     
//             }),
//       ),
//     );
//   }
// }

// final _primarySwatch = MaterialColor(MyColors.primaryColor.value, _swatch);
// final _swatch = {
//   50: MyColors.primaryColor.withOpacity(0.1),
//   100: MyColors.primaryColor.withOpacity(0.2),
//   200: MyColors.primaryColor.withOpacity(0.3),
//   300: MyColors.primaryColor.withOpacity(0.4),
//   400: MyColors.primaryColor.withOpacity(0.5),
//   500: MyColors.primaryColor.withOpacity(0.6),
//   600: MyColors.primaryColor.withOpacity(0.7),
//   700: MyColors.primaryColor.withOpacity(0.8),
//   800: MyColors.primaryColor.withOpacity(0.9),
//   900: MyColors.primaryColor.withOpacity(1),
// };
