
class OrderModel {
  String id;
  String offerId;
  DateTime orderStartedTime;
  DateTime deliveryTime;
  DateTime? orderCompletedTime;
  bool orderEnded;
  // bool orderCancelled;
  
  OrderModel({
    required this.id,
    required this.offerId,
    required this.orderStartedTime,
    required this.deliveryTime,
    this.orderCompletedTime,
    required this.orderEnded,
    //  this.orderCancelled=false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'offerId': offerId,
      'orderStartedTime': orderStartedTime.millisecondsSinceEpoch, 
      'deliveryTime': deliveryTime.millisecondsSinceEpoch, 
      'orderCompletedTime': orderCompletedTime?.millisecondsSinceEpoch, 
      // 'orderCancelled': orderCancelled, 
      'orderEnded': orderEnded, 
    };
  }
  factory OrderModel.emptyOrder(){
    return OrderModel(
      id: "", 
      offerId: "", 
      orderStartedTime:DateTime.fromMillisecondsSinceEpoch(0), 
      deliveryTime: DateTime.fromMillisecondsSinceEpoch(0), 
      orderEnded: false);
  }
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    print(map);

    return OrderModel(
      id: map['id'],
      offerId: map['offerId'],
      orderStartedTime: DateTime.fromMillisecondsSinceEpoch(map['orderStartedTime']),
      deliveryTime:  DateTime.fromMillisecondsSinceEpoch(map['deliveryTime']),
      orderCompletedTime: DateTime.fromMillisecondsSinceEpoch(map['orderCompletedTime'] ?? 0),
      // orderCancelled: map['orderCancelled'] ?? false,
      orderEnded: map['orderEnded'] ?? false,
    );
  }
}
