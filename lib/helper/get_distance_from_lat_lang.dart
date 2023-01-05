import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

String getDistanceBetweenTwoGeoPoint(GeoPoint from, GeoPoint to) {
  Distance distance = const Distance();

  final double _km = distance.as(LengthUnit.Kilometer,
      LatLng(from.latitude, from.longitude), LatLng(to.latitude, to.longitude));

  final double _meter = distance(
      LatLng(from.latitude, from.longitude), LatLng(to.latitude, to.longitude));
  print("meter is $_meter");
  return _meter != 0
      ? _meter < 1000
          ? _meter.toStringAsFixed(0) + "m away"
          : _km.toStringAsFixed(0) + "km away"
      : "";
}

double getDistanceBetweenTwoGeoPointQuery(GeoPoint from, GeoPoint to) {
  Distance distance = const Distance();

  final double _km = distance.as(LengthUnit.Kilometer,
      LatLng(from.latitude, from.longitude), LatLng(to.latitude, to.longitude));

  // final double _meter = distance(
  //     LatLng(from.latitude, from.longitude), LatLng(to.latitude, to.longitude));

  return _km;
}
