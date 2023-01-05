import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_offer_builder.dart';
import 'package:protibeshi_app/views/others/space_horizontal.dart';
import 'package:protibeshi_app/views/tabs/dashboard/components/colour_button.dart';
import 'package:protibeshi_app/views/tabs/dashboard/components/offer_card.dart';
import 'package:protibeshi_app/views/tabs/dashboard/components/received_card.dart';


class OfferRecievedPage extends StatefulWidget {
  const OfferRecievedPage({Key? key}) : super(key: key);
  @override
  State<OfferRecievedPage> createState() => _OfferRecievedPageState();
}

class _OfferRecievedPageState extends State<OfferRecievedPage> {
   int taskIndex = 0;
  int widgetIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      AllOffer(placeIndex: taskIndex),
      PendingOffer(placeIndex: taskIndex),
      AcceptedOffer(placeIndex: taskIndex),
      CancelledOffer(placeIndex: taskIndex),
    ];
    final onSurfaceTextColour =
        Theme.of(context).colorScheme.onSurface.withOpacity(0.5);
    final onSurfaceBorderColour =
        Theme.of(context).colorScheme.onSurface.withOpacity(0.2);
    final onSurfaceBackgColour =
        Theme.of(context).colorScheme.onSurface.withOpacity(0.05);
    final primaryColour = Theme.of(context).colorScheme.primary;
    final primaryBackgColour =
        Theme.of(context).colorScheme.primary.withOpacity(0.1);
    const orangeColour = Colors.orange;
    final orangeBackgColour = Colors.orange.withOpacity(0.1);
    print("object3");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              //   const SpaceHorizontal(15),
              ColourButton(
                  selectedIndex: taskIndex,
                  title: "All",
                  constIndex: 0,
                  backgroundColor:
                      taskIndex == 0 ? orangeBackgColour : onSurfaceBackgColour,
                  borderColor:
                      taskIndex == 0 ? orangeColour : onSurfaceBorderColour,
                  titleColor:
                      taskIndex == 0 ? orangeColour : onSurfaceTextColour,
                  onPressed: () {
                    setState(() {
                      taskIndex = 0;
                    });
                    print(taskIndex);
                  }),
              const SpaceHorizontal(5),
              ColourButton(
                selectedIndex: taskIndex,
                title: "from Post",
                constIndex: 1,
                backgroundColor:
                    taskIndex == 1 ? orangeBackgColour : onSurfaceBackgColour,
                borderColor:
                    taskIndex == 1 ? orangeColour : onSurfaceBorderColour,
                titleColor: taskIndex == 1 ? orangeColour : onSurfaceTextColour,
                onPressed: () {
                  setState(() {
                    taskIndex = 1;
                  });
                },
              ),
              const SpaceHorizontal(5),
              ColourButton(
                selectedIndex: taskIndex,
                title: "direct Offers",
                constIndex: 2,
                backgroundColor:
                    taskIndex == 2 ? orangeBackgColour : onSurfaceBackgColour,
                borderColor:
                    taskIndex == 2 ? orangeColour : onSurfaceBorderColour,
                titleColor: taskIndex == 2 ? orangeColour : onSurfaceTextColour,
                onPressed: () {
                  setState(() {
                    taskIndex = 2;
                  });
                },
              ),
              const SpaceHorizontal(5),
            ],
          ),
        ),
        const Divider(),
        Container(
          height: 50,
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              ColourButton(
                selectedIndex: widgetIndex,
                title: "All",
                constIndex: 0,
                backgroundColor: widgetIndex == 0
                    ? primaryBackgColour
                    : onSurfaceBackgColour,
                borderColor:
                    widgetIndex == 0 ? primaryColour : onSurfaceBorderColour,
                titleColor:
                    widgetIndex == 0 ? primaryColour : onSurfaceTextColour,
                onPressed: () {
                  setState(() {
                    widgetIndex = 0;
                  });
                },
              ),
              const SpaceHorizontal(1),
              ColourButton(
                selectedIndex: widgetIndex,
                title: "Pending",
                constIndex: 1,
                backgroundColor: widgetIndex == 1
                    ? primaryBackgColour
                    : onSurfaceBackgColour,
                borderColor:
                    widgetIndex == 1 ? primaryColour : onSurfaceBorderColour,
                titleColor:
                    widgetIndex == 1 ? primaryColour : onSurfaceTextColour,
                onPressed: () {
                  setState(() {
                    widgetIndex = 1;
                  });
                },
              ),
              const SpaceHorizontal(1),
              ColourButton(
                selectedIndex: widgetIndex,
                title: "Accepted",
                constIndex: 2,
                backgroundColor: widgetIndex == 2
                    ? primaryBackgColour
                    : onSurfaceBackgColour,
                borderColor:
                    widgetIndex == 2 ? primaryColour : onSurfaceBorderColour,
                titleColor:
                    widgetIndex == 2 ? primaryColour : onSurfaceTextColour,
                onPressed: () {
                  setState(() {
                    widgetIndex = 2;
                  });
                },
              ),
              const SpaceHorizontal(1),
              ColourButton(
                selectedIndex: widgetIndex,
                title: "Cancelled",
                constIndex: 3,
                backgroundColor: widgetIndex == 3
                    ? primaryBackgColour
                    : onSurfaceBackgColour,
                borderColor:
                    widgetIndex == 3 ? primaryColour : onSurfaceBorderColour,
                titleColor:
                    widgetIndex == 3 ? primaryColour : onSurfaceTextColour,
                onPressed: () {
                  setState(() {
                    widgetIndex = 3;
                  });
                },
              ),
              const SpaceHorizontal(1),
            ],
          ),
        ),
        Expanded(child: widgetList[widgetIndex]),
      ],
    );
  }
}

class AllOffer extends ConsumerWidget {
  const AllOffer({required this.placeIndex, Key? key}) : super(key: key);
  final int placeIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserOrdersBuilder(builder: ((context, userOffersList, orderList) {
      final receiveAllOffers = userOffersList
          .where((offer) =>
              (!offer.isPostOffer &&
                  offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid) ||
              (offer.isPostOffer &&
                  offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid))
          .toList();
      final receiveExploreOffers = userOffersList
          .where((offer) =>
              !offer.isPostOffer &&
              offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final receivePostOffers = userOffersList
          .where((offer) =>
              offer.isPostOffer &&
              offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final list = [receiveAllOffers, receiveExploreOffers, receivePostOffers];
      return list[placeIndex].isNotEmpty
          ? ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 150),
              children: list[placeIndex].map((userOffer) {
                final userId =
                    userOffer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid
                        ? userOffer.sellerId
                        : userOffer.buyerId;

                return OfferCard(
                        offerModel: userOffer, fromReceive: true, fromSent: false,
                      );
              }).toList())
          : const Center(
              child: Text("No offers receive."),
            );
    }));
  }
}

class PendingOffer extends ConsumerWidget {
  const PendingOffer({required this.placeIndex, Key? key}) : super(key: key);
  final int placeIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserOrdersBuilder(builder: ((context, userOffersList, orderList) {
      final pendingOffers = userOffersList
          .where((offer) => !offer.offerAccepted && !offer.offerCancelled)
          .toList();
      final receiveAllOffers = pendingOffers
          .where((offer) =>
              (offer.isPostOffer &&
                  offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid) ||
              (!offer.isPostOffer &&
                  offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid))
          .toList();
      final receiveExploreOffers = pendingOffers
          .where((offer) =>
              !offer.isPostOffer &&
              offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final receivePostOffers = pendingOffers
          .where((offer) =>
              offer.isPostOffer &&
              offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final list = [receiveAllOffers, receivePostOffers, receiveExploreOffers];
      return list[placeIndex].isNotEmpty
          ? ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 150),
              children: list[placeIndex].map((userOffer) {
                final userId =
                    userOffer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid
                        ? userOffer.sellerId
                        : userOffer.buyerId;
                return OfferCard(
                        offerModel: userOffer, fromReceive: true, fromSent: false,
                      );
              }).toList())
          : const Center(
              child: Text("No offers"),
            );
    }));
  }
}

class AcceptedOffer extends ConsumerWidget {
  const AcceptedOffer({required this.placeIndex, Key? key}) : super(key: key);
  final int placeIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserOrdersBuilder(builder: ((context, userOffersList, orderList) {
      final acceptOffers = userOffersList
          .where((offer) => offer.offerAccepted && !offer.offerCancelled)
          .toList();
      final receiveAllOffers = acceptOffers
          .where((offer) =>
              (offer.isPostOffer &&
                  offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid) ||
              (!offer.isPostOffer &&
                  offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid))
          .toList();
      final receiveExploreOffers = acceptOffers
          .where((offer) =>
              !offer.isPostOffer &&
              offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final receivePostOffers = acceptOffers
          .where((offer) =>
              offer.isPostOffer &&
              offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final list = [receiveAllOffers, receivePostOffers, receiveExploreOffers];
      return list[placeIndex].isNotEmpty
          ? ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 150),
              children: list[placeIndex].map((userOffer) {
                final userId =
                    userOffer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid
                        ? userOffer.sellerId
                        : userOffer.buyerId;
                 return OfferCard(
                        offerModel: userOffer, fromReceive: true, fromSent: false,
                      );
              }).toList())
          : const Center(
              child: Text("No accept offers"),
            );
    }));
  }
}

class CancelledOffer extends ConsumerWidget {
  const CancelledOffer({required this.placeIndex, Key? key}) : super(key: key);
  final int placeIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserOrdersBuilder(builder: ((context, userOffersList, orderList) {
      final cancelledOffers = userOffersList
          .where((offer) => !offer.offerAccepted && offer.offerCancelled)
          .toList();
      final receiveAllOffers = cancelledOffers
          .where((offer) =>
              (offer.isPostOffer &&
                  offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid) ||
              (!offer.isPostOffer &&
                  offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid))
          .toList();
      final receiveExploreOffers = cancelledOffers
          .where((offer) =>
              !offer.isPostOffer &&
              offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final receivePostOffers = cancelledOffers
          .where((offer) =>
              offer.isPostOffer &&
              offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final list = [receiveAllOffers, receivePostOffers, receiveExploreOffers];
      return list[placeIndex].isNotEmpty
          ? ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 150),
              children: list[placeIndex].map((userOffer) {
                final userId =
                    userOffer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid
                        ? userOffer.sellerId
                        : userOffer.buyerId;
                 return OfferCard(
                        offerModel: userOffer, fromReceive: true, fromSent: false,
                      );
              }).toList())
          : const Center(
              child: Text("No cancelled offers"),
            );
    }));
  }
}

