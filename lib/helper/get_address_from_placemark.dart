import 'package:geocoding/geocoding.dart';

String getAddressFromPlacemark(Placemark placemark) {
  return "${placemark.name == "" ? "" : "${placemark.name}, "}${placemark.thoroughfare == "" ? "" : "${placemark.thoroughfare}, "}${placemark.subLocality == "" ? "" : "${placemark.subLocality}, "}${placemark.locality == "" ? "" : "${placemark.locality}, "}${placemark.country == "" ? "" : placemark.country}";
}
