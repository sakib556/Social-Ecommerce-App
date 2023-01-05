
class UserDueModel {

 String id;
 String sellerId;
 String orderId;
 double duesInTk;
 DateTime dueStartedTime;
 String sellerBkashNumber;
 String  adminBkashNumber;
 
  UserDueModel({
    required this.id,
    required this.sellerId,
    required this.orderId,
    required this.duesInTk,
    required this.dueStartedTime,
    required this.sellerBkashNumber,
    required this.adminBkashNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sellerId': sellerId,
      'orderId': orderId,
      'duesInTk': duesInTk,
      'dueStartedTime': dueStartedTime.millisecondsSinceEpoch,
      'sellerBkashNumber': sellerBkashNumber,
      'adminBkashNumber': adminBkashNumber,
    };
  }

  factory UserDueModel.fromMap(Map<String, dynamic> map) {
    return UserDueModel(
      id: map['id'] as String,
      sellerId: map['sellerId'] as String,
      orderId: map['orderId'] as String,
      duesInTk: map['duesInTk'] as double,
      dueStartedTime: DateTime.fromMillisecondsSinceEpoch(map['dueStartedTime'] as int),
      sellerBkashNumber: map['sellerBkashNumber'] as String,
      adminBkashNumber: map['adminBkashNumber'] as String,
    );
  }

 
}
