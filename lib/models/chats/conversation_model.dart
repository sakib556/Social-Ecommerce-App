import 'dart:convert';

import 'package:collection/collection.dart';

class ConversationModel {
  String id;
  List<String> userIds;
  DateTime lastMessageTime;
  bool isArchived;
  bool isMuted;
  ConversationModel({
    required this.id,
    required this.userIds,
    required this.lastMessageTime,
    this.isArchived = false,
    this.isMuted = false,
  });

  ConversationModel copyWith({
    String? id,
    List<String>? userIds,
    DateTime? lastMessageTime,
    bool? isArchived,
    bool? isMuted,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      userIds: userIds ?? this.userIds,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      isArchived: isArchived ?? this.isArchived,
      isMuted: isMuted ?? this.isMuted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userIds': userIds,
      'lastMessageTime': lastMessageTime.millisecondsSinceEpoch,
      'isArchived': isArchived,
      'isMuted': isMuted,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      id: map['id'],
      userIds: List<String>.from(map['userIds']),
      lastMessageTime:
          DateTime.fromMillisecondsSinceEpoch(map['lastMessageTime']),
      isArchived: map['isArchived'],
      isMuted: map['isMuted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) =>
      ConversationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConversationModel(id: $id, userIds: $userIds, lastMessageTime: $lastMessageTime, isArchived: $isArchived, isMuted: $isMuted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ConversationModel &&
        other.id == id &&
        listEquals(other.userIds, userIds) &&
        other.lastMessageTime == lastMessageTime &&
        other.isArchived == isArchived &&
        other.isMuted == isMuted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userIds.hashCode ^
        lastMessageTime.hashCode ^
        isArchived.hashCode ^
        isMuted.hashCode;
  }
}
