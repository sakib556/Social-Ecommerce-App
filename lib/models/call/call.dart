// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CallModel {
  String id;
  String token;
  String meetingId;
  String callerId;
  String receiverId;
  CallModel({
    required this.id,
    required this.token,
    required this.meetingId,
    required this.callerId,
    required this.receiverId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'token': token,
      'meetingId': meetingId,
      'callerId': callerId,
      'receiverId': receiverId,
    };
  }

  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
      id: map['id'] as String,
      token: map['token'] as String,
      meetingId: map['meetingId'] as String,
      callerId: map['callerId'] as String,
      receiverId: map['receiverId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CallModel.fromJson(String source) => CallModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
