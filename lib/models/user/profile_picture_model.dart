class ProfilePictureModel {
  String imageUrl;
  String userId;
  DateTime time;
  ProfilePictureModel({
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

  factory ProfilePictureModel.fromMap(Map<String, dynamic> map) {
    return ProfilePictureModel(
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }
}
