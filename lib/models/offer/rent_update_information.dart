class RentUpdateInformation{
  String costFirstDay;
  String costPerExtraDay;
  DateTime startDate;
  DateTime endDate;
  int durationInDays;
  DateTime lastUpdateTime;
  List<String> updateInformations;
  List<String> userMessages;
  int upadateCount;
  bool buyerCanEdit;
  bool sellerCanEdit;
  RentUpdateInformation({
    required this.costFirstDay,
    required this.costPerExtraDay,
    required this.startDate,
    required this.endDate,
    required this.durationInDays,
    required this.lastUpdateTime,
    required this.updateInformations,
    required this.userMessages,
    this.upadateCount = 0,
    this.buyerCanEdit = false,
    this.sellerCanEdit = false,
  });


  Map<String, dynamic> toMap() {
    return {
      'costFirstDay': costFirstDay,
      'costPerExtraDay': costPerExtraDay,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'durationInDays': durationInDays,
      'lastUpdateTime': lastUpdateTime.millisecondsSinceEpoch,
      'updateInformations': updateInformations,
      'userMessages': userMessages,
      'buyerCanEdit': buyerCanEdit,
      'upadateCount': upadateCount,
      'sellerCanEdit': sellerCanEdit,
    };
  }

  factory RentUpdateInformation.fromMap(Map<String, dynamic> map) {
    return RentUpdateInformation(
      costFirstDay: map['costFirstDay'],
      costPerExtraDay: map['costPerExtraDay'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      durationInDays: map['durationInDays'],
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
