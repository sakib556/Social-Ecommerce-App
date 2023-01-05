import 'dart:convert';

class LocationModel {
  String id;
  String userId;

  String house;
  String street;
  String area;
  String? city;
  String? country;
  int locationType;
  dynamic geoLocation;
  DateTime time;
  LocationModel({
    required this.id,
    required this.userId,
    required this.house,
    required this.street,
    required this.area,
    this.city,
    this.country,
    required this.locationType,
    this.geoLocation,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'house': house,
      'street': street,
      'area': area,
      'city': city,
      'country': country,
      'locationType': locationType,
      'geoLocation': geoLocation,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'],
      userId: map['userId'],
      house: map['house'],
      street: map['street'],
      area: map['area'],
      city: map['city'],
      country: map['country'],
      locationType: map['locationType'],
      geoLocation: map['geoLocation'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  LocationModel copyWith({
    String? id,
    String? userId,
    String? house,
    String? street,
    String? area,
    String? city,
    String? country,
    int? locationType,
    dynamic geoLocation,
    DateTime? time,
  }) {
    return LocationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      house: house ?? this.house,
      street: street ?? this.street,
      area: area ?? this.area,
      city: city ?? this.city,
      country: country ?? this.country,
      locationType: locationType ?? this.locationType,
      geoLocation: geoLocation ?? this.geoLocation,
      time: time ?? this.time,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationModel(id: $id, userId: $userId, house: $house, street: $street, area: $area, city: $city, country: $country, locationType: $locationType, geoLocation: $geoLocation, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationModel &&
        other.id == id &&
        other.userId == userId &&
        other.house == house &&
        other.street == street &&
        other.area == area &&
        other.city == city &&
        other.country == country &&
        other.locationType == locationType &&
        other.geoLocation == geoLocation &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        house.hashCode ^
        street.hashCode ^
        area.hashCode ^
        city.hashCode ^
        country.hashCode ^
        locationType.hashCode ^
        geoLocation.hashCode ^
        time.hashCode;
  }
}
