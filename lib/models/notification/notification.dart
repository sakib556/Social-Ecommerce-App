
class NotificationModel {

  String id;
  String offferId;
  String? orderId;
  String receiverId;
  bool isRead;
  DateTime sentTime;
  DateTime? readTime;
  
  NotificationModel({
    required this.id,
    required this.offferId,
     this.orderId,
    required this.receiverId,
    required this.isRead,
    required this.sentTime,
     this.readTime,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'offferId': offferId,
      'orderId': orderId,
      'receiverId': receiverId,
      'isRead': isRead,
      'sentTime': sentTime.millisecondsSinceEpoch,
      'readTime': readTime?.millisecondsSinceEpoch,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String,
      offferId: map['offferId'] as String,
      orderId: map['orderId'] ,
      receiverId: map['receiverId'] as String,
      isRead: map['isRead'] as bool,
      sentTime: DateTime.fromMillisecondsSinceEpoch(map['sentTime']  ?? 0),
      readTime: DateTime.fromMillisecondsSinceEpoch(map['readTime']  ?? 0),
    );
  }

}