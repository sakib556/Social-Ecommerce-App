import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:protibeshi_app/helper/config_loading.dart';
import 'package:protibeshi_app/providers/auth_provider.dart';
import 'package:protibeshi_app/providers/theme_provider.dart';
import 'package:protibeshi_app/themes/colors.dart';
import 'package:protibeshi_app/translations/codegen_loader.g.dart';
import 'package:protibeshi_app/views/auth/first_take_profile.dart';
import 'package:protibeshi_app/views/auth/sign_up_methods_screen.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_basic_builder.dart';
import 'package:protibeshi_app/views/other_pages/loading.dart';
import 'package:protibeshi_app/views/other_pages/something_went_wrong.dart';
import 'package:protibeshi_app/views/tabs/bottom_nav_bar_page.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> _handleBackgroundNotification(RemoteMessage message) async {
  await Firebase.initializeApp();

  print(message.notification!.title);
  print(message.notification!.body);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_handleBackgroundNotification);
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('bn')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        assetLoader: const CodegenLoader(),
        child: const rp.ProviderScope(child: MainApp())),
  );
  configLoading();
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return rp.Consumer(
      builder: ((context, ref, child) {
        final isDark = ref.watch(themeProvider);

        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Protibeshi',
          debugShowCheckedModeBanner: false,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
              useMaterial3: true,
              primarySwatch: _primarySwatch,
              chipTheme: ChipThemeData.fromDefaults(
                secondaryColor: Theme.of(context).colorScheme.primary,
                brightness: ThemeData.light().brightness,
                labelStyle: ThemeData.light().textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              appBarTheme: const AppBarTheme(backgroundColor: Colors.white)),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            primarySwatch: _primarySwatch,
            chipTheme: ChipThemeData(
              brightness: ThemeData.dark().brightness,
              labelStyle: ThemeData.dark().textTheme.bodyText1!.copyWith(),
            ),
          ),
          home: const LandingPage(),
          //   home:  const MapTest(),
          builder: EasyLoading.init(),
        );
      }),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: rp.Consumer(
          builder: (context, ref, child) => ref
              .watch(authStateChangeProvider)
              .maybeMap(
                loading: (_) => const Loading(),
                orElse: () => const Loading(),
                loaded: (_) => _.data.isNotEmpty
                    ? UserBasicBuilder(
                        builder: (context, userBasicModel, isOnline) {
                          return userBasicModel.isProfileSaved
                              ? const BottomNavBarPage()
                              : const FirstTakeProfileInfo();
                        },
                      )
                    : const SignUpMethodsScreen(),
                error: (_) => const SomethingWentWrong(errorMessage: ("error")),
              )),
    ));
  }
}

final _primarySwatch = MaterialColor(MyColors.primaryColor.value, _swatch);
final _swatch = {
  50: MyColors.primaryColor.withOpacity(0.1),
  100: MyColors.primaryColor.withOpacity(0.2),
  200: MyColors.primaryColor.withOpacity(0.3),
  300: MyColors.primaryColor.withOpacity(0.4),
  400: MyColors.primaryColor.withOpacity(0.5),
  500: MyColors.primaryColor.withOpacity(0.6),
  600: MyColors.primaryColor.withOpacity(0.7),
  700: MyColors.primaryColor.withOpacity(0.8),
  800: MyColors.primaryColor.withOpacity(0.9),
  900: MyColors.primaryColor.withOpacity(1),
};

class MapTest extends StatelessWidget {
  const MapTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MapSample();
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
