import 'package:protibeshi_app/models/offer/rent_update_information.dart';
import 'package:protibeshi_app/models/offer/sell_update_information.dart';

class OfferModel {
  String id;
  String buyerId;
  String sellerId;
  String listingId;
  String? postId;
  bool isPostOffer;
  dynamic pickupLocationCode; 
  String pickupLocationName;
  DateTime pickupTime;
  DateTime offerSentTime;
  bool offerAccepted;
  bool offerCancelled;
  DateTime? offerAcceptedTime;
  DateTime? offerCancelledTime;
  RentUpdateInformation? rentUpdateInformation;
  SellUpdateInformation? sellUpdateInformation;
  OfferModel({
    required this.id,
    required this.buyerId,
    required this.sellerId,
    required this.listingId,
    this.postId,
    required this.pickupLocationCode,
    required this.pickupLocationName,
    required this.pickupTime,
    required this.offerSentTime,
    required this.isPostOffer,
    this.offerAccepted = false,
    this.offerAcceptedTime,
    this.offerCancelled = false,
    this.offerCancelledTime,
    this.rentUpdateInformation,
    this.sellUpdateInformation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buyerId': buyerId,
      'sellerId': sellerId,
      'listingId': listingId,
      'postId': postId,
      'rentUpdateInformation': rentUpdateInformation?.toMap(),
      'sellUpdateInformation': sellUpdateInformation?.toMap(),
      'pickupLocationCode': pickupLocationCode,
      'pickupLocationName': pickupLocationName,
      'pickupTime': pickupTime.millisecondsSinceEpoch,
      'offerSentTime': offerSentTime.millisecondsSinceEpoch,
      'postOffer': isPostOffer,
      'offerAccepted': offerAccepted,
      'offerCanceled': offerCancelled,
      'offerAcceptedTime': offerAcceptedTime?.millisecondsSinceEpoch,
      'offerCancelledTime': offerCancelledTime?.millisecondsSinceEpoch,
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
      id: map['id'],
      buyerId: map['buyerId'],
      sellerId: map['sellerId'],
      listingId: map['listingId'],
      postId: map['postId'],
      rentUpdateInformation:
          map['rentUpdateInformation'] != null ? RentUpdateInformation.fromMap(map['rentUpdateInformation']):null,
      sellUpdateInformation:
          map['sellUpdateInformation'] != null ? SellUpdateInformation.fromMap(map['sellUpdateInformation']):null,
      pickupLocationCode: map['pickupLocationCode'],
      pickupLocationName: map['pickupLocationName'],
      isPostOffer: map['postOffer'],
      pickupTime: DateTime.fromMillisecondsSinceEpoch(map['pickupTime']),
      offerSentTime: DateTime.fromMillisecondsSinceEpoch(map['offerSentTime']),
      offerAccepted: map['offerAccepted'] ?? false,
      offerCancelled: map['offerCanceled'] ?? false,
      offerAcceptedTime:
          DateTime.fromMillisecondsSinceEpoch(map['offerAcceptedTime'] ?? 0),
      offerCancelledTime:
          DateTime.fromMillisecondsSinceEpoch(map['offerCancelledTime'] ?? 0),
    );
  }
}
