class CoverPictureModel {
  String imageUrl;
  String userId;
  DateTime time;
  CoverPictureModel({
    required this.imageUrl,
    required this.userId,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'userId': userId,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory CoverPictureModel.fromMap(Map<String, dynamic> map) {
    return CoverPictureModel(
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }
}
