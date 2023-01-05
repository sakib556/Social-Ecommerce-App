
class UserPaidModel {
 String id;
 String lastTotalDueInTk;
 String paidDueInTk;
 DateTime paidTime;


  UserPaidModel({
    required this.id,
    required this.lastTotalDueInTk,
    required this.paidDueInTk,
    required this.paidTime,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lastTotalDueInTk': lastTotalDueInTk,
      'paidDueInTk': paidDueInTk,
      'paidTime': paidTime.millisecondsSinceEpoch,
    };
  }

  factory UserPaidModel.fromMap(Map<String, dynamic> map) {
    return UserPaidModel(
      id: map['id'] as String,
      lastTotalDueInTk: map['lastTotalDueInTk'] as String,
      paidDueInTk: map['paidDueInTk'] as String,
      paidTime: DateTime.fromMillisecondsSinceEpoch(map['paidTime'] as int),
    );
  }

}
