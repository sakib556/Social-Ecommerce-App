import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/models/offer/offer.dart';
import 'package:protibeshi_app/models/order/order.dart';
import 'package:protibeshi_app/providers/offer_provider.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/listing_builder.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_alert_dialogue.dart';
import 'package:protibeshi_app/views/others/space_horizontal.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/tabs/dashboard/components/qr_code_generator.dart';
import 'package:protibeshi_app/views/tabs/dashboard/components/qr_code_scanner.dart';

class OrderDetailsPage extends ConsumerWidget {
  const OrderDetailsPage({Key? key, required this.offerModel, this.orderModel})
      : super(key: key);
  final OfferModel offerModel;
  final OrderModel? orderModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetList = [
      BikeCard(listingId: offerModel.listingId),
      BookCard(listingId: offerModel.listingId),
      HomeMadeFoodCard(listingId: offerModel.listingId),
      ServiceCard(listingId: offerModel.listingId),
      TeachingCard(listingId: offerModel.listingId),
    ];
    final subCategoryList = [
      "Bike",
      "Book",
      "HomeMadeFood",
      "Service",
      "Teaching",
    ];
    return Scaffold(
      body: ListingBuilder(builder: ((context, listings) {
        final list = listings
            .where((element) => element.listingId == offerModel.listingId)
            .toList();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              list.isNotEmpty
                  ? widgetList[
                      subCategoryList.indexOf(list.first.subCategoryId)]
                  : const Text("Go back and\nReload your listings first!"),
              const SpaceVertical(10),
              orderModel == null ||
                      (orderModel != null && !orderModel!.orderEnded)
                  ? offerModel.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QrCodeGeneratorScreen(
                                        offer: offerModel)));
                          },
                          child: const Text("QR Code as seller"))
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QrScannerScreen(
                                        offerModel: offerModel,
                                        orderModel: orderModel)));
                          },
                          child: const Text("QR Scanner as buyer")) //code
                  : const SizedBox(),
              const SpaceVertical(10),
              const Text("Order Details"),
              orderModel == null
                  ? ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CustomAlertDialog(
                                    title: "Order cancel",
                                    content:
                                        "Would you like to cancel the order?",
                                    yesOnPressed: () {
                                      offerModel.offerCancelled = true;
                                      ref
                                          .read(offerProvider.notifier)
                                          .cancelOffer(offerModel);
                                      ref
                                          .read(getOfferProvider.notifier)
                                          .getOffers();
                                      Navigator.pop(context);
                                    },
                                    noOnPressed: () {
                                      Navigator.pop(context);
                                    },
                                    yesText: "yes",
                                    noText: "no"));
                      },
                      child: const Text("Cancel"))
                  : const SizedBox()
            ],
          ),
        );
      })),
    );
  }
}

class OfferDetailsPage extends ConsumerWidget {
  const OfferDetailsPage(
      {Key? key, required this.offerModel, required this.fromReceive})
      : super(key: key);
  final OfferModel offerModel;
  final bool fromReceive;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetList = [
      BikeCard(listingId: offerModel.listingId),
      BookCard(listingId: offerModel.listingId),
      HomeMadeFoodCard(listingId: offerModel.listingId),
      ServiceCard(listingId: offerModel.listingId),
      TeachingCard(listingId: offerModel.listingId),
    ];
    final subCategoryList = [
      "Bike",
      "Book",
      "HomeMadeFood",
      "Service",
      "Teaching",
    ];
    return SafeArea(
      child: Scaffold(
        body: ListingBuilder(builder: ((context, listings) {
          final list = listings
              .where((element) => element.listingId == offerModel.listingId)
              .toList();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                list.isNotEmpty
                    ? widgetList[
                        subCategoryList.indexOf(list.first.subCategoryId)]
                    : const Text("Go back and\nReload your listings first!"),
                const SpaceVertical(10),
                const Text("Offer Details"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !offerModel.offerAccepted
                        ? ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomAlertDialog(
                                          title: "Offer cancel",
                                          content:
                                              "Would you like to cancel the offer?",
                                          yesOnPressed: () {
                                            offerModel.offerCancelled = true;
                                            ref
                                                .read(offerProvider.notifier)
                                                .cancelOffer(offerModel);
                                            ref
                                                .read(getOfferProvider.notifier)
                                                .getOffers();
                                            Navigator.pop(context);
                                          },
                                          noOnPressed: () {
                                            Navigator.pop(context);
                                          },
                                          yesText: "yes",
                                          noText: "no"));
                            },
                            child: const Text("Cancel"))
                        : const SizedBox(),
                    fromReceive && !offerModel.offerAccepted && !offerModel.offerCancelled
                        ? Row(
                          children: [
                            const SpaceHorizontal(10),
                            ElevatedButton(
                                onPressed: () async {
                                  offerModel.offerAccepted = true;
                                  await ref
                                      .read(offerProvider.notifier)
                                      .acceptOffer(offerModel);
                                  await ref
                                      .read(getOfferProvider.notifier)
                                      .getOffers();
                                  EasyLoading.showSuccess("Accepted");
                                },
                                child: const Text("Accept"),
                              ),
                          ],
                        )
                        : const SizedBox()
                  ],
                ),
              ],
            ),
          );
        })),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({Key? key, required this.listingId}) : super(key: key);
  final String listingId;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("BookCard"));
  }
}

class BikeCard extends StatelessWidget {
  const BikeCard({Key? key, required this.listingId}) : super(key: key);
  final String listingId;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("BikeCard"));
  }
}

class HomeMadeFoodCard extends StatelessWidget {
  const HomeMadeFoodCard({Key? key, required this.listingId}) : super(key: key);
  final String listingId;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("HomeMadeFoodCard"));
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({Key? key, required this.listingId}) : super(key: key);
  final String listingId;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("ServiceCard"));
  }
}

class TeachingCard extends StatelessWidget {
  const TeachingCard({Key? key, required this.listingId}) : super(key: key);
  final String listingId;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("TeachingCard"));
  }
}
