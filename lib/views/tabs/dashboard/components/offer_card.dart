import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/date_formatter.dart';
import 'package:protibeshi_app/models/listing/listing_model.dart';
import 'package:protibeshi_app/models/offer/offer.dart';
import 'package:protibeshi_app/providers/offer_provider.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_basic_builder.dart';
import 'package:protibeshi_app/views/custom_widgets/user_distance_text.dart';
import 'package:protibeshi_app/views/others/space_horizontal.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/listing_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:protibeshi_app/views/tabs/dashboard/components/details_offer_order__page.dart';

class OfferCard extends ConsumerWidget {
  const OfferCard(
      {Key? key,
      required this.offerModel,
      required this.fromReceive,
      required this.fromSent})
      : super(key: key);
  final OfferModel offerModel;
  final bool fromReceive;
  final bool fromSent;
  //final OrderModel? orderModel;
  //final BorrowPostModel
//  final UserBasicModel userModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sentTime = offerModel.offerSentTime;
    int differenceTime =
        DateFormatter.differenceInHours(sentTime, DateTime.now());
    int respondTime = 24 - differenceTime;
    final String userId = offerModel.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid
        ? offerModel.buyerId
        : offerModel.sellerId;
    // final startDate = offerModel.rentUpdateInformation != null ?
    // offerModel.rentUpdateInformation!.startDate
    // : offerModel.pickupTime;
    return UserBasicBuilder(
        userId: userId,
        builder: (context, user, isOnline) {
          return UserPictureBuilder(
              userId: userId,
              builder: (context, profilePic, cover) {
                return ListingBuilder(builder: (context, listings) {
                  final List<ListingModel> listing = listings
                      .where((element) =>
                          element.listingId == offerModel.listingId)
                      .toList();
                  return listing.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OfferDetailsPage(
                                            offerModel: offerModel, fromReceive: fromReceive,),
                                      ),
                                    );
                            }),
                            child: SizedBox(
                              height: 230,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          OfferTitle(listing: listing.first),
                                          const SpaceVertical(5),
                                          Text(
                                            differenceTime < 24
                                                ? "$respondTime hours left to respond"
                                                : "Respond time is 24 hours\ngone.Offer again..",
                                            style: const TextStyle(
                                              color: Colors.orange,
                                            ),
                                          ),
                                          const SpaceVertical(10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground
                                                    .withOpacity(0.45),
                                                size: 20,
                                              ),
                                              const SpaceHorizontal(10),
                                              Text(
                                                DateFormatter.toDMY(
                                                    offerModel.pickupTime),
                                                textAlign: TextAlign.end,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ],
                                          ),
                                          const SpaceVertical(5),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.watch_later_outlined,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground
                                                    .withOpacity(0.45),
                                                size: 20,
                                              ),
                                              const SpaceHorizontal(10),
                                              Text(
                                                DateFormatter.toTime(
                                                    offerModel.pickupTime),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ],
                                          ),
                                          const SpaceVertical(5),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground
                                                    .withOpacity(0.45),
                                                size: 20,
                                              ),

                                              const SpaceHorizontal(10),
                                              SizedBox(
                                                width: 160,
                                                child: UserDistanceText(
                                                    locationName: offerModel
                                                        .pickupLocationName,
                                                    locationCode: offerModel
                                                        .pickupLocationCode),
                                              ),

                                              // Text("200m away"),
                                            ],
                                          ),
                                          const SpaceVertical(5),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_right_outlined,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground
                                                    .withOpacity(0.45),
                                                size: 20,
                                              ),
                                              const SpaceHorizontal(10),
                                              Text(
                                                  offerModel.isPostOffer
                                                      ? "From post"
                                                      : "From explore",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SpaceVertical(5),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              clipBehavior: Clip.hardEdge,
                                              child: Container(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withOpacity(0.40),
                                                child: profilePic.isEmpty
                                                    ? const Padding(
                                                        padding:
                                                            EdgeInsets.all(12),
                                                        child: Icon(
                                                          Icons.person,
                                                          size: 60,
                                                        ),
                                                      )
                                                    : Hero(
                                                        tag: offerModel.id,
                                                        // tag: profilePic
                                                        //     .first.imageUrl,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: profilePic
                                                              .first.imageUrl,
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          const SpaceVertical(10),
                                          Center(
                                            child: SizedBox(
                                              width: 80,
                                              child: Text(
                                                user.name ?? "No name",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          fromReceive
                                              ? !offerModel.offerAccepted &&
                                                      !offerModel.offerCancelled
                                                  ? ElevatedButton(
                                                      onPressed: () async {
                                                        offerModel
                                                                .offerAccepted =
                                                            true;
                                                        await ref
                                                            .read(offerProvider
                                                                .notifier)
                                                            .acceptOffer(
                                                                offerModel);
                                                        await ref
                                                            .read(
                                                                getOfferProvider
                                                                    .notifier)
                                                            .getOffers();
                                                        EasyLoading.showSuccess(
                                                            "Accepted");
                                                      },
                                                      child:
                                                          const Text("Accept"),
                                                    )
                                                  : const SizedBox()
                                              : const SizedBox(),
                                          fromReceive &&
                                                      offerModel
                                                          .offerAccepted ||
                                                  fromSent &&
                                                      offerModel.offerAccepted
                                              ? const Text("Accepted")
                                              : const SizedBox()
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Text("empty");
                });
              });
        });
  }
}

class OfferTitle extends StatelessWidget {
  const OfferTitle({Key? key, required this.listing}) : super(key: key);
  final ListingModel listing;
  @override
  Widget build(BuildContext context) {
    final String forProduct =
        "${listing.subCategoryId} - ${listing.forRent ? "Rent" : "Sell"}";
    final String forOthers = listing.categoryId == "Service"
        ? "${listing.subCategoryId} - ${listing.categoryId}"
        : "Learn ${listing.subCategoryId}";
    final String title =
        listing.categoryId == "Product" ? forProduct : forOthers;
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}
