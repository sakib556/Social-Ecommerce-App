import 'dart:convert';

class VerificationItemModel {
  String itemOne;
  String? itemTwo;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  String? statusMessage;
  VerificationItemModel({
    required this.itemOne,
    this.itemTwo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.statusMessage,
  });

  VerificationItemModel copyWith({
    String? itemOne,
    String? itemTwo,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? statusMessage,
  }) {
    return VerificationItemModel(
      itemOne: itemOne ?? this.itemOne,
      itemTwo: itemTwo ?? this.itemTwo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemOne': itemOne,
      'itemTwo': itemTwo,
      'status': status,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'statusMessage': statusMessage,
    };
  }

  factory VerificationItemModel.fromMap(Map<String, dynamic> map) {
    return VerificationItemModel(
      itemOne: map['itemOne'] ?? '',
      itemTwo: map['itemTwo'],
      status: map['status']?.toInt() ?? 0,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      statusMessage: map['statusMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VerificationItemModel.fromJson(String source) =>
      VerificationItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VerificationItemModel(itemOne: $itemOne, itemTwo: $itemTwo, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, statusMessage: $statusMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VerificationItemModel &&
        other.itemOne == itemOne &&
        other.itemTwo == itemTwo &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.statusMessage == statusMessage;
  }

  @override
  int get hashCode {
    return itemOne.hashCode ^
        itemTwo.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        statusMessage.hashCode;
  }
}

class VerificationModel {
  VerificationItemModel? photoID;
  VerificationItemModel? selfie;
  VerificationItemModel? utility;
  VerificationModel({
    this.photoID,
    this.selfie,
    this.utility,
  });

  Map<String, dynamic> toMap() {
    return {
      'photoID': photoID?.toMap(),
      'selfie': selfie?.toMap(),
      'utility': utility?.toMap(),
    };
  }

  factory VerificationModel.fromMap(Map<String, dynamic> map) {
    return VerificationModel(
      photoID: map['photoID'] != null
          ? VerificationItemModel.fromMap(map['photoID'])
          : null,
      selfie: map['selfie'] != null
          ? VerificationItemModel.fromMap(map['selfie'])
          : null,
      utility: map['utility'] != null
          ? VerificationItemModel.fromMap(map['utility'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerificationModel.fromJson(String source) =>
      VerificationModel.fromMap(json.decode(source));

  VerificationModel copyWith({
    VerificationItemModel? photoID,
    VerificationItemModel? selfie,
    VerificationItemModel? utility,
  }) {
    return VerificationModel(
      photoID: photoID ?? this.photoID,
      selfie: selfie ?? this.selfie,
      utility: utility ?? this.utility,
    );
  }
}
