import 'dart:convert';

class UserBasicModel {
  String id;
  String? name;
  String? phone;
  String? email;
  String? bio;
  String? birthday;
  String? gender;
  bool isVerified;
  DateTime joiningTime;
  bool isProfileSaved;
  UserBasicModel({
    required this.id,
    this.name,
    this.phone,
    this.email,
    this.bio,
    this.birthday,
    this.gender,
    this.isVerified = false,
    required this.joiningTime,
    required this.isProfileSaved,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'bio': bio,
      'birthday': birthday,
      'gender': gender,
      'isVerified': isVerified,
      'joiningTime': joiningTime.millisecondsSinceEpoch,
      'isProfileSaved': isProfileSaved,
    };
  }

  factory UserBasicModel.fromMap(Map<String, dynamic> map) {
    return UserBasicModel(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      bio: map['bio'],
      birthday: map['birthday'],
      gender: map['gender'],
      isVerified: map['isVerified'],
      joiningTime: DateTime.fromMillisecondsSinceEpoch(map['joiningTime']),
      isProfileSaved: map['isProfileSaved'],
    );
  }

  UserBasicModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? bio,
    String? birthday,
    String? gender,
    bool? isVerified,
    DateTime? joiningTime,
    bool? isProfileSaved,
  }) {
    return UserBasicModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      isVerified: isVerified ?? this.isVerified,
      joiningTime: joiningTime ?? this.joiningTime,
      isProfileSaved: isProfileSaved ?? this.isProfileSaved,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserBasicModel.fromJson(String source) =>
      UserBasicModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserBasicModel(id: $id, name: $name, phone: $phone, email: $email, bio: $bio, birthday: $birthday, gender: $gender, isVerified: $isVerified, joiningTime: $joiningTime, isProfileSaved: $isProfileSaved)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserBasicModel &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.bio == bio &&
        other.birthday == birthday &&
        other.gender == gender &&
        other.isVerified == isVerified &&
        other.joiningTime == joiningTime &&
        other.isProfileSaved == isProfileSaved;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        bio.hashCode ^
        birthday.hashCode ^
        gender.hashCode ^
        isVerified.hashCode ^
        joiningTime.hashCode ^
        isProfileSaved.hashCode;
  }
}
