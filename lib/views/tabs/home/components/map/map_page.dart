import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as maps_tool;
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:protibeshi_app/views/others/space_horizontal.dart';
import 'package:protibeshi_app/views/tabs/bottom_nav_bar_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:protibeshi_app/themes/colors.dart';
import 'package:protibeshi_app/providers/user_provider.dart';
import 'package:protibeshi_app/views/tabs/profile/settings/save_home_address.dart';

class MapPage extends StatefulWidget {
  ///1 for home, 2 for work, others for custom!
  final int locationType;

  final LatLng? latLng;
  final String house;
  final String street;
  final String area;

  final bool fromFirstPage;

  const MapPage({
    Key? key,
    required this.locationType,
    this.latLng,
    required this.house,
    required this.street,
    required this.area,
    this.fromFirstPage = false,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _mapController;
  late Position _currentPosition;
  String _house = "";
  String _street = "";
  String _area = "";
  LatLng _latlng = const LatLng(45, 128);
  List<Placemark> _placeMarks = [];
  bool isInselectedArea = true;
  bool _locationPermissionDenied = false;
  final List<LatLng> _polygonPoints = const [
    LatLng(23.812918, 90.425156),
    LatLng(23.813350, 90.432564),
    LatLng(23.814861, 90.436192),
    LatLng(23.817716, 90.449081),
    LatLng(23.829494, 90.447835),
    LatLng(23.825803, 90.429627),
    LatLng(23.820503, 90.424989),
    LatLng(23.820672, 90.420976),
    LatLng(23.814194, 90.421406),
    LatLng(23.812054, 90.421492),
    LatLng(23.812604, 90.424713),
    LatLng(23.812918, 90.425156),
  ];
  void locatePostion() async {
    try {
      if (widget.latLng == null) {
        _currentPosition = await getCurrentPosition();
        _latlng = const LatLng(23.818933, 90.437360);
        // _latlng = LatLng(_currentPosition.latitude, _currentPosition.longitude);
      } else {
        _latlng = widget.latLng!;
      }

      CameraPosition _cameraPosition = CameraPosition(
        target: _latlng,
        zoom: 16,
      );

      _placeMarks =
          await placemarkFromCoordinates(_latlng.latitude, _latlng.longitude);

      setState(() {});

      _mapController
          .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    } catch (e) {
      _locationPermissionDenied = true;
    }
  }

  void checkUpdatedLocation(LatLng pointLatLng) {
    List<maps_tool.LatLng> convertedPolygonPoints = _polygonPoints
        .map((e) => maps_tool.LatLng(e.latitude, e.longitude))
        .toList();
    setState(() {
      isInselectedArea = maps_tool.PolygonUtil.containsLocationAtLatLng(
          pointLatLng.latitude,
          pointLatLng.longitude,
          convertedPolygonPoints,
          false);
    });
  }

  void checkLocationAddress() {
    setState(() {
      _house = widget.house;
      _street = widget.street;
      _area = widget.area;
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition _kGooglePlex = CameraPosition(
      target: _latlng,
      zoom: 16,
    );

    List<Marker> _markers = <Marker>[];

    _markers.add(
      Marker(
      markerId: const MarkerId('marker'),
      position: _latlng,
      infoWindow: InfoWindow.noText,
      draggable: true,
      onDragEnd: (updatedLatLng) {
        checkUpdatedLocation(updatedLatLng);
      },
    ));

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              markers: _markers.toSet(),
              mapType: MapType.normal,
              buildingsEnabled: true,
              indoorViewEnabled: true,
              minMaxZoomPreference: const MinMaxZoomPreference(0, 28),
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onTap: (LatLng latlng) async {
                _placeMarks = await placemarkFromCoordinates(
                    latlng.latitude, latlng.longitude);
                setState(() {
                  _latlng = latlng;
                  print("update location5");
                  checkUpdatedLocation(latlng);
                });
              },
              onMapCreated: (GoogleMapController controller) {
                checkLocationAddress();
                _controller.complete(controller);
                if (!_locationPermissionDenied) {
                  _mapController = controller;
                  locatePostion();
                } else {
                  EasyLoading.showError('Location Permission Denied');
                }
              },
              myLocationEnabled: true,
              polygons: {
                Polygon(
                    polygonId: const PolygonId("1"),
                    points: _polygonPoints,
                    fillColor: Colors.blue.withOpacity(0.2),
                    strokeWidth: 2)
              },
            ),
            _placeMarks.isNotEmpty
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: MyColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: MyColors.blackColor.withOpacity(0.2),
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.15),
                        padding: const EdgeInsets.only(
                            top: 24, bottom: 0, left: 16, right: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          //  crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_house}, ${_street}, ${_area}",
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.ubuntu().fontFamily,
                                  ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 24,
                                  child: rp.Consumer(
                                      builder: (context, ref, widg) {
                                    return OutlinedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SaveHomeAddress(
                                                      house: widget.house,
                                                      street: widget.street,
                                                      area: widget.area,
                                                      onSave: (house,
                                                          street,
                                                          area,
                                                          _context) async {
                                                        setState(() {
                                                          _house = house;
                                                          _street = street;
                                                          _area = area;
                                                        });
                                                        EasyLoading.show(
                                                            status: "Saving..");
                                                        print(
                                                            "house : ${_house}");
                                                        print(
                                                            "street : ${_street}");
                                                        print(
                                                            "area : ${_area}");
                                                        await SaveCurrentPositionNotifier
                                                            .saveCurrentPosition(
                                                                area: _area,
                                                                house: _house,
                                                                street: _street,
                                                                locationType: 1,
                                                                latlng:
                                                                    _latlng);

                                                        widget.fromFirstPage
                                                            ? await ref
                                                                .watch(
                                                                    userFirstTimeUdateProfileProvider
                                                                        .notifier)
                                                                .updateProfileFirstTime()
                                                            : null;
                                                        //  await ref.read(userLocatio)
                                                        await ref
                                                            .read(userLocationsProvider(
                                                                    FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                .notifier)
                                                            .userLocations();
                                                        EasyLoading.showSuccess(
                                                            "Saved!");
                                                        Navigator.of(_context)
                                                            .pop();
                                                      }),
                                            ),
                                          );
                                        },
                                        child: const Text("edit"));
                                  }),
                                ),
                                const SpaceHorizontal(10),
                              ],
                            ),

                            //   const SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${widget.locationType == 1 ? 'Home' : widget.locationType == 2 ? 'Work' : 'Custom'} Location",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: Colors.black),
                                ),
                                rp.Consumer(builder: (context, ref, child) {
                                  return widget.fromFirstPage
                                      ? isInselectedArea
                                          ? ElevatedButton(
                                              onPressed: () async {
                                                await SaveCurrentPositionNotifier
                                                    .saveCurrentPosition(
                                                        area: widget.area,
                                                        house: widget.house,
                                                        street: widget.street,
                                                        locationType:
                                                            widget.locationType,
                                                        latlng: _latlng);
                                                EasyLoading.showSuccess(
                                                    "Saved!");
                                                await ref
                                                    .watch(
                                                        userFirstTimeUdateProfileProvider
                                                            .notifier)
                                                    .updateProfileFirstTime();

                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const BottomNavBarPage(),
                                                    ),
                                                    (route) => false);
                                              },
                                              child: const Text("Next"))
                                          : const Text("Out of area")
                                      : ButtonBar(
                                          alignment: MainAxisAlignment.end,
                                          children: [
                                            OutlinedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel")),
                                            isInselectedArea
                                                ? ElevatedButton(
                                                    onPressed: () async {
                                                      EasyLoading.show(
                                                          status:
                                                              "Saving new location...");
                                                      await SaveCurrentPositionNotifier
                                                          .saveCurrentPosition(
                                                              area: _area,
                                                              house: _house,
                                                              street: _street,
                                                              locationType: widget
                                                                  .locationType,
                                                              latlng: _latlng);
                                                      await ref
                                                          .read(userLocationsProvider(
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                              .notifier)
                                                          .userLocations();
                                                      EasyLoading.showSuccess(
                                                          "Location saved!");
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Save"))
                                                : const Text("Out of area")
                                          ],
                                        );
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            //  GestureDetector(
            //   onTap: (){

            //   },
            //   child: const Icon(Icons.gps_fixed)
            //  )
          ],
        ),
      ),
    );
  }
}
