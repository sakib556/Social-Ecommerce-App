import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:protibeshi_app/models/user/location_model.dart';

GeoPoint getGeoPointFromLocationModel(LocationModel location) {
  GeoPoint _geoPoint = location.geoLocation["geopoint"] as GeoPoint;
  return _geoPoint;
}
