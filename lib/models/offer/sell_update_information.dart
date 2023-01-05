class SellUpdateInformation{
  String cost;
  DateTime lastUpdateTime;
  List<String> updateInformations;
  List<String> userMessages;
  int upadateCount;
  bool buyerCanEdit;
  bool sellerCanEdit;
  SellUpdateInformation({
    required this.cost,
    required this.lastUpdateTime,
    required this.updateInformations,
    required this.userMessages,
    this.upadateCount = 0,
    this.buyerCanEdit = false,
    this.sellerCanEdit = false,
  });


  Map<String, dynamic> toMap() {
    return {
      'cost': cost,
      'lastUpdateTime': lastUpdateTime.millisecondsSinceEpoch,
      'updateInformations': updateInformations,
      'userMessages': userMessages,
      'buyerCanEdit': buyerCanEdit,
      'upadateCount': upadateCount,
      'sellerCanEdit': sellerCanEdit,
    };
  }

  factory SellUpdateInformation.fromMap(Map<String, dynamic> map) {
    return SellUpdateInformation(
      cost: map['cost'],
      lastUpdateTime:
          DateTime.fromMillisecondsSinceEpoch(map['lastUpdateTime']),
      userMessages: List<String>.from(map['userMessages']),
      updateInformations: List<String>.from(map['updateInformations']),
      buyerCanEdit: map['buyerCanEdit'],
      upadateCount: map['upadateCount'],
      sellerCanEdit: map['sellerCanEdit'],
    );
  }
}
