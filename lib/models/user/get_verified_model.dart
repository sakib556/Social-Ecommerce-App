import 'dart:convert';

class GetVerifiedModel {
  String id;
  String userId;
  String photoIdFrontViewUrl;
  String photoIdBackViewUrl;
  String selfieUrl;
  String utilityBillUrl;
  DateTime createdAt;
  DateTime updatedAt;
  bool isPending;
  bool isApproved;
  String? statusMessage;
  GetVerifiedModel({
    required this.id,
    required this.userId,
    required this.photoIdFrontViewUrl,
    required this.photoIdBackViewUrl,
    required this.selfieUrl,
    required this.utilityBillUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.isPending,
    required this.isApproved,
    this.statusMessage,
  });

  GetVerifiedModel copyWith({
    String? id,
    String? userId,
    String? photoIdFrontViewUrl,
    String? photoIdBackViewUrl,
    String? selfieUrl,
    String? utilityBillUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPending,
    bool? isApproved,
    String? statusMessage,
  }) {
    return GetVerifiedModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      photoIdFrontViewUrl: photoIdFrontViewUrl ?? this.photoIdFrontViewUrl,
      photoIdBackViewUrl: photoIdBackViewUrl ?? this.photoIdBackViewUrl,
      selfieUrl: selfieUrl ?? this.selfieUrl,
      utilityBillUrl: utilityBillUrl ?? this.utilityBillUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPending: isPending ?? this.isPending,
      isApproved: isApproved ?? this.isApproved,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'photoIdFrontViewUrl': photoIdFrontViewUrl,
      'photoIdBackViewUrl': photoIdBackViewUrl,
      'selfieUrl': selfieUrl,
      'utilityBillUrl': utilityBillUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'isPending': isPending,
      'isApproved': isApproved,
      'statusMessage': statusMessage,
    };
  }

  factory GetVerifiedModel.fromMap(Map<String, dynamic> map) {
    return GetVerifiedModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      photoIdFrontViewUrl: map['photoIdFrontViewUrl'] ?? '',
      photoIdBackViewUrl: map['photoIdBackViewUrl'] ?? '',
      selfieUrl: map['selfieUrl'] ?? '',
      utilityBillUrl: map['utilityBillUrl'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      isPending: map['isPending'] ?? false,
      isApproved: map['isApproved'] ?? false,
      statusMessage: map['statusMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GetVerifiedModel.fromJson(String source) =>
      GetVerifiedModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetVerifiedModel(id: $id, userId: $userId, photoIdFrontViewUrl: $photoIdFrontViewUrl, photoIdBackViewUrl: $photoIdBackViewUrl, selfieUrl: $selfieUrl, utilityBillUrl: $utilityBillUrl, createdAt: $createdAt, updatedAt: $updatedAt, isPending: $isPending, isApproved: $isApproved, statusMessage: $statusMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetVerifiedModel &&
        other.id == id &&
        other.userId == userId &&
        other.photoIdFrontViewUrl == photoIdFrontViewUrl &&
        other.photoIdBackViewUrl == photoIdBackViewUrl &&
        other.selfieUrl == selfieUrl &&
        other.utilityBillUrl == utilityBillUrl &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.isPending == isPending &&
        other.isApproved == isApproved &&
        other.statusMessage == statusMessage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        photoIdFrontViewUrl.hashCode ^
        photoIdBackViewUrl.hashCode ^
        selfieUrl.hashCode ^
        utilityBillUrl.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        isPending.hashCode ^
        isApproved.hashCode ^
        statusMessage.hashCode;
  }
}
