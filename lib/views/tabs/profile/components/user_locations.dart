import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_location_builder.dart';
import 'package:protibeshi_app/views/tabs/home/components/map/map_page.dart';
import 'package:protibeshi_app/helper/get_geo_point.dart';
import 'package:protibeshi_app/models/user/location_model.dart';

class UserLocations extends StatelessWidget {
  const UserLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My locations"),
      ),
      body: UserLocationBuilder(
        builder: (context, location) {
          LocationModel? _home;

          if (location.isNotEmpty) {
            for (var l in location) {
              if (l.locationType == 1) {
                _home = l;
              } else if (l.locationType == 2) {}
            }
          }

          LatLng? _getLatLng(LocationModel? location) {
            if (location == null) {
              return null;
            } else {
              GeoPoint _point = getGeoPointFromLocationModel(location);
              return LatLng(_point.latitude, _point.longitude);
            }
          }

          return ListView(
            children: [
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.home_filled),
                title: const Text("Home"),
                subtitle:
                    Text("${_home?.house}, ${_home?.street}, ${_home?.area}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapPage(
                        area: _home!.area,
                        house: _home.house,
                        street: _home.street,
                        locationType: 1,
                        latLng: _home.geoLocation == null
                          ? null
                           : _getLatLng(_home),
                      ),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
              // const SizedBox(height: 10),
              // ListTile(
              //   leading: const Icon(Icons.work),
              //   title: const Text("Work"),
              //   subtitle: _work == null
              //       ? null
              //       : Text("${_work.house}, ${_work.street}, ${_work.area}"),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => MapPage(
              //           area: _work!.area,
              //           house: _work.house,
              //           street: _work.street,
              //           locationType: 2,
              //           latLng: _work.geoLocation == null
              //               ? null
              //               : _getLatLng(_work),
              //         ),
              //         fullscreenDialog: true,
              //       ),
              //     );
              //   },
              // ),
            ],
          );
        },
      ),
    );
  }
}
