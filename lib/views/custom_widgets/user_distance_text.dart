import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:protibeshi_app/helper/get_distance_from_lat_lang.dart';
import 'package:protibeshi_app/helper/get_geo_point.dart';
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_location_builder.dart';

class UserDistanceText extends StatelessWidget {
  const UserDistanceText(
      {Key? key, required this.locationName, required this.locationCode})
      : super(key: key);
  final String locationName;
  final dynamic locationCode;
  @override
  Widget build(BuildContext context) {
    return UserLocationBuilder(
      builder: (context, locationModels) {
        if (UserLocations.userAllLocations.isNotEmpty &&
            UserLocations.userAllLocations.first.geoLocation != null) {
          GeoPoint _userLocation =
              getGeoPointFromLocationModel(UserLocations.userAllLocations[0]);
          GeoPoint _postLocation = (locationCode["geopoint"] as GeoPoint);

          String _distance =
              getDistanceBetweenTwoGeoPoint(_userLocation, _postLocation);

          return _distance.isNotEmpty
              ? Text(
                  _distance,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                )
              : Text(
                  locationName,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                );
        } else {
          return Text(
            locationName,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          );
        }
      },
    );
  }
}
