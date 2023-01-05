// ignore_for_file: public_member_api_docs, sort_constructors_first
class BorrowPostModel {
  String id;
  String userId;
  String postText;
  List<String> postImages;
  dynamic locationCode;
  double distance;
  String locationName;
  String postBudget;
  DateTime startDate;
  DateTime endDate;
  int durationInDays;
  DateTime pickupTime;
  DateTime postTime;
  String  subCategoryName;
  BorrowPostModel({
    required this.id,
    required this.userId,
    required this.postText,
    required this.postImages,
    required this.locationCode,
    this.distance=0,
    required this.locationName,
    required this.postBudget,
    required this.startDate,
    required this.endDate,
    required this.durationInDays,
    required this.pickupTime,
    required this.postTime,
    required this.subCategoryName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'postText': postText,
      'postImages': postImages,
      'locationCode': locationCode,
      'locationName': locationName,
      'subCategoryName': subCategoryName,
      'postBudget': postBudget,
      'durationInDays': durationInDays,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'postTime': postTime.millisecondsSinceEpoch,
      'pickupTime': pickupTime.millisecondsSinceEpoch,
    };
  }

  factory BorrowPostModel.fromMap(Map<String, dynamic> map) {
    return BorrowPostModel(
      id: map['id'],
      userId: map['userId'],
      postText: map['postText'],
      postImages: List<String>.from(map['postImages']),
      locationCode: map['locationCode'],
      locationName: map['locationName'],
      subCategoryName : map['subCategoryName'],
      postBudget: map['postBudget'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      durationInDays: map['durationInDays'],
      postTime: DateTime.fromMillisecondsSinceEpoch(map['postTime']),
      pickupTime: DateTime.fromMillisecondsSinceEpoch(map['pickupTime']),
    );
  }
}
