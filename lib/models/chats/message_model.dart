import 'dart:convert';

import 'package:collection/collection.dart';

class MessageModel {
  String id;
  String conversationId;
  String? message;
  List<String>? attachments;
  String userId;
  DateTime createdAt;
  bool isRead;
  MessageModel({
    required this.id,
    required this.conversationId,
    this.message,
    required this.attachments,
    required this.userId,
    required this.createdAt,
    this.isRead = false,
  });

  MessageModel copyWith({
    String? id,
    String? converstationId,
    String? message,
    List<String>? attachments,
    String? userId,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return MessageModel(
      id: id ?? this.id,
      conversationId: converstationId ?? this.conversationId,
      message: message ?? this.message,
      attachments: attachments ?? this.attachments,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'converstationId': conversationId,
      'message': message,
      'attachments': attachments,
      'userId': userId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isRead': isRead,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      conversationId: map['converstationId'],
      message: map['message'],
      attachments: List<String>.from(map['attachments'] ?? []),
      userId: map['userId'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      isRead: map['isRead'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(id: $id, converstationId: $conversationId, message: $message, attachments: $attachments, userId: $userId, createdAt: $createdAt, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is MessageModel &&
        other.id == id &&
        other.conversationId == conversationId &&
        other.message == message &&
        listEquals(other.attachments, attachments) &&
        other.userId == userId &&
        other.createdAt == createdAt &&
        other.isRead == isRead;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        conversationId.hashCode ^
        message.hashCode ^
        attachments.hashCode ^
        userId.hashCode ^
        createdAt.hashCode ^
        isRead.hashCode;
  }
}
