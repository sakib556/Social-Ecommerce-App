class NameChipModel {
  String label;
  bool selected;
  NameChipModel({required this.label, this.selected = false});
}

class PhotoViewGridModel {
  String url;
  String itemName;
  String? location;
  double amount;
  PhotoViewGridModel(
      {required this.url,
      required this.itemName,
      this.location,
      required this.amount});
}
