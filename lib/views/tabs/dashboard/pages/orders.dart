import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/models/offer/offer.dart';
import 'package:protibeshi_app/models/order/order.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_alert_dialogue.dart';
import 'package:protibeshi_app/views/custom_widgets/user_avatar.dart';
import 'package:protibeshi_app/helper/date_formatter.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_offer_builder.dart';
import 'package:protibeshi_app/views/others/space_horizontal.dart';
import 'package:protibeshi_app/views/tabs/dashboard/components/colour_button.dart';
import 'package:protibeshi_app/views/tabs/dashboard/components/offer_card.dart';
import 'package:protibeshi_app/views/tabs/dashboard/components/order_card.dart';
import 'package:protibeshi_app/views/tabs/dashboard/components/qr_code_generator.dart';
import 'package:protibeshi_app/views/tabs/dashboard/components/qr_code_scanner.dart';
import 'package:protibeshi_app/providers/offer_provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);
  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int taskIndex = 0;
  int widgetIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      AllOrder(placeIndex: taskIndex),
      PendingOrder(placeIndex: taskIndex),
      ActiveOrder(placeIndex: taskIndex),
      DoneOrder(placeIndex: taskIndex),
      CancelledOrder(placeIndex: taskIndex),
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
                    print("object4");
                    setState(() {
                      taskIndex = 0;
                      print("object44");
                    });
                    print(taskIndex);
                  }),
              const SpaceHorizontal(5),
              ColourButton(
                selectedIndex: taskIndex,
                title: "Given",
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
                title: "Taken",
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
                title: "Active",
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
                title: "Done",
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
              ColourButton(
                selectedIndex: widgetIndex,
                title: "Cancelled",
                constIndex: 4,
                backgroundColor: widgetIndex == 4
                    ? primaryBackgColour
                    : onSurfaceBackgColour,
                borderColor:
                    widgetIndex == 4 ? primaryColour : onSurfaceBorderColour,
                titleColor:
                    widgetIndex == 4 ? primaryColour : onSurfaceTextColour,
                onPressed: () {
                  setState(() {
                    widgetIndex = 4;
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

class AllOrder extends ConsumerWidget {
  const AllOrder({required this.placeIndex, Key? key}) : super(key: key);
  final int placeIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserOrdersBuilder(builder: ((context, userOffersList, orderList) {
      final givenAllOrders = userOffersList
          .where((offer) => offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final takenAllOrders = userOffersList
          .where((offer) => offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final list = [userOffersList, givenAllOrders, takenAllOrders];
      print("place index $placeIndex");
      return list[placeIndex].isNotEmpty
          ? ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 150),
              children: list[placeIndex].map((userOffer) {
                // final userOrder = orderList.firstWhere(
                //     (orders) => orders.offerId == userOffer.id,
                //     orElse: () => OrderModel.emptyOrder());
                return userOffer.offerAccepted
                    ? OrderCard(
                        offerModel: userOffer, fromReceive: false, fromSent: false,
                      )
                    : const SizedBox();
              }).toList())
          : const Center(
              child: Text("No orders"),
            );
    }));
  }
}

class PendingOrder extends ConsumerWidget {
  const PendingOrder({required this.placeIndex, Key? key}) : super(key: key);
  final int placeIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserOrdersBuilder(builder: ((context, userOffersList, orderList) {
      final givenAllOrders = userOffersList
          .where((offer) => offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final takenAllOrders = userOffersList
          .where((offer) => offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final list = [userOffersList, givenAllOrders, takenAllOrders];
      print("place index $placeIndex");
      return list[placeIndex].isNotEmpty
          ? ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 150),
              children: list[placeIndex].map((userOffer) {
                // var userOrder =
                //     orderList.where((orders) => userOffer.id == orders.offerId,orElse:()=>);
                final userOrder = orderList.firstWhere(
                    (orders) => orders.offerId == userOffer.id,
                    orElse: () => OrderModel.emptyOrder());
                return userOrder.id.isEmpty &&
                        !userOffer.offerCancelled &&
                        userOffer.offerAccepted
                    ? OrderCard(
                        offerModel: userOffer, fromReceive: false, fromSent: false,
                      )
                    : const SizedBox();
              }).toList())
          : const Center(
              child: Text("No orders"),
            );
    }));
  }
}

class PendingOrderShow extends StatelessWidget {
  const PendingOrderShow({Key? key, required this.order, required this.offer})
      : super(key: key);
  final OrderModel order;
  final OfferModel offer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PendingOrderDetails(
                    order: order,
                    offer: offer,
                  )),
        );
      },
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              children: [
                UserAvatar(userId: offer.sellerId),
                const SizedBox(width: 8),
                Text(DateFormatter.toTime(offer.offerSentTime)),
              ],
            ),
            Text("accepted : ${offer.offerAccepted}"),
            Text("canceled : ${offer.offerCancelled}"),
            offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QrCodeGeneratorScreen(
                                    offer: offer
                                  )));
                    },
                    child: const Text("QR Code as buyer"))
                : ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QrScannerScreen(
                                  offerModel: offer, orderModel: order)));
                    },
                    child: const Text("QR Scanner as as seller"))
          ]),
        ),
        const Divider()
      ]),
    );
  }
}

class PendingOrderDetails extends ConsumerWidget {
  const PendingOrderDetails(
      {Key? key, required this.order, required this.offer})
      : super(key: key);
  final OrderModel order;
  final OfferModel offer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              const Text("Details - "),
              Text("Listing id : ${offer.listingId}"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    children: [
                      UserAvatar(userId: offer.sellerId),
                      const SizedBox(width: 8),
                      Text(DateFormatter.toTime(offer.offerSentTime)),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CustomAlertDialog(
                                    title: "Order cancel",
                                    content:
                                        "Would you like to cancel the order?",
                                    yesOnPressed: () {
                                      ref
                                          .read(offerProvider.notifier)
                                          .cancelOffer(offer);
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
                ]),
              ),
              const Divider()
            ]),
      ),
    );
  }

  showAlertDialog(BuildContext context, VoidCallback onPressed) {
    // set up the buttons
    Widget noButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget yesButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        onPressed();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    return AlertDialog(
      title: const Text("Cancel order."),
      content: const Text("Would you like to cancel the order?"),
      actions: [
        noButton,
        yesButton,
      ],
    );
  }
}

class ActiveOrder extends ConsumerWidget {
  const ActiveOrder({required this.placeIndex, Key? key}) : super(key: key);
  final int placeIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserOrdersBuilder(builder: ((context, userOffersList, orderList) {
      final givenAllOrders = userOffersList
          .where((offer) => offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final takenAllOrders = userOffersList
          .where((offer) => offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final list = [userOffersList, givenAllOrders, takenAllOrders];
      print("place index $placeIndex");
      return list[placeIndex].isNotEmpty
          ? ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 150),
              children: list[placeIndex].map((userOffer) {
                final userOrder = orderList.where((orders) =>
                    userOffer.id == orders.offerId && !orders.orderEnded);
                return userOrder.isNotEmpty && !userOffer.offerCancelled 
                    ? OrderCard(
                        offerModel: userOffer, 
                        fromReceive: false, 
                        fromSent: false,
                        orderModel: userOrder.first,
                      )
                    : const SizedBox();
              }).toList())
          : const Center(
              child: Text("No active orders"),
            );
    }));
  }
}

class ActiveOrderShow extends StatelessWidget {
  const ActiveOrderShow({Key? key, required this.order, required this.offer})
      : super(key: key);
  final OrderModel order;
  final OfferModel offer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PendingOrderDetails(
                    order: order,
                    offer: offer,
                  )),
        );
      },
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              children: [
                UserAvatar(userId: offer.sellerId),
                const SizedBox(width: 8),
                Text(DateFormatter.toTime(offer.offerSentTime)),
              ],
            ),
            // Text("cost : ${offer}"),
            // Text("duration : ${order.durationInDays}"),
            Text("accepted : ${offer.offerAccepted}"),
            Text("canceled : ${offer.offerCancelled}"),
            Text("orderStartedTime : ${order.orderStartedTime}"),
            Text("deliveryTime : ${order.deliveryTime}"),
            Text("orderEnded : ${order.orderEnded}"),
            Text("orderCompletedTime : ${order.orderCompletedTime}"),
            // Text("locationName : ${order.locationName}"),
            // Text(
            //     "pickupTime : ${DateFormatter.toTime(order.pickupTime)}"),
            // Text(
            //     "startDate : ${order.startDate["date"]} month: ${order.startDate["month"]}"),
            // Text(
            //     "endDate : ${order.endDate["date"]} month: ${order.endDate["month"]}"),
            offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QrCodeGeneratorScreen(
                                    offer: offer,
                                  )));
                    },
                    child: const Text("QR Code as buyer"))
                : ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QrScannerScreen(
                                  offerModel: offer, orderModel: order)));
                    },
                    child: const Text("QR Scanner as as seller"))
          ]),
        ),
        const Divider()
      ]),
    );
  }
}

class ActiveOrderDetails extends StatelessWidget {
  const ActiveOrderDetails({Key? key, required this.order, required this.offer})
      : super(key: key);
  final OrderModel order;
  final OfferModel offer;

  @override
  Widget build(BuildContext context) {
    // BookModel bookModel = BookModel.fromMap(order.listingInformation);

    return const Text("No worked");
  }
}

class DoneOrder extends ConsumerWidget {
  const DoneOrder({required this.placeIndex, Key? key}) : super(key: key);
  final int placeIndex;
// need order start model
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserOrdersBuilder(builder: ((context, userOffersList, orderList) {
      final givenAllOrders = userOffersList
          .where((offer) => offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final takenAllOrders = userOffersList
          .where((offer) => offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final list = [userOffersList, givenAllOrders, takenAllOrders];
      print("place index $placeIndex");
      return list[placeIndex].isNotEmpty
          ? ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 150),
              children: list[placeIndex].map((userOffer) {
                final userOrder = orderList.where((orders) =>
                    userOffer.id == orders.offerId && orders.orderEnded);
                return userOrder.isNotEmpty
                    ? OrderCard(
                        offerModel: userOffer, fromReceive: false, fromSent: false,
                        orderModel: userOrder.first,
                      )
                    : const SizedBox();
              }).toList())
          : const Center(
              child: Text("No orders"),
            );
    }));
  }
}

class DoneOrderShow extends StatelessWidget {
  const DoneOrderShow({Key? key, required this.order, required this.offer})
      : super(key: key);
  final OrderModel order;
  final OfferModel offer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                children: [
                  UserAvatar(userId: offer.sellerId),
                  const SizedBox(width: 8),
                  Text(DateFormatter.toTime(offer.offerSentTime)),
                ],
              ),
              // Text("cost : ${offer}"),
              // Text("duration : ${order.durationInDays}"),
              Text("accepted : ${offer.offerAccepted}"),
              Text("canceled : ${offer.offerCancelled}"),
              Text("orderStartedTime : ${order.orderStartedTime}"),
              Text("deliveryTime : ${order.deliveryTime}"),
              Text("orderEnded : ${order.orderEnded}"),
              Text("orderCompletedTime : ${order.orderCompletedTime}"),
              // Text("locationName : ${order.locationName}"),
              // Text(
              //     "pickupTime : ${DateFormatter.toTime(order.pickupTime)}"),
              // Text(
              //     "startDate : ${order.startDate["date"]} month: ${order.startDate["month"]}"),
              // Text(
              //     "endDate : ${order.endDate["date"]} month: ${order.endDate["month"]}"),
              const Divider()
            ])));
  }
}

class CancelledOrder extends ConsumerWidget {
  const CancelledOrder({required this.placeIndex, Key? key}) : super(key: key);
  final int placeIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserOrdersBuilder(builder: ((context, userOffersList, orderList) {
      final givenAllOrders = userOffersList
          .where((offer) => offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final takenAllOrders = userOffersList
          .where((offer) => offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
          .toList();
      final list = [userOffersList, givenAllOrders, takenAllOrders];
      print("place index $placeIndex");
      return list[placeIndex].isNotEmpty
          ? ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 150),
              children: list[placeIndex].map((userOffer) {
                final list = userOffersList
                    .where(
                        (offer) => offer.offerCancelled && offer.offerAccepted)
                    .toList();
                return list.isNotEmpty
                    ? OrderCard(
                        offerModel: list.first, fromReceive: false, fromSent: false,
                      )
                    : Container();
              }).toList())
          : const Center(
              child: Text("No cancelled orders"),
            );
    }));
  }
}

class CancelledOrderShow extends StatelessWidget {
  const CancelledOrderShow({Key? key, required this.offer}) : super(key: key);
  final OfferModel offer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => PendingOrderDetails(
        //             order: order,
        //             offer: offer,
        //           )),
        // );
      },
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              children: [
                UserAvatar(userId: offer.sellerId),
                const SizedBox(width: 8),
                Text(DateFormatter.toTime(offer.offerSentTime)),
              ],
            ),
            // Text("cost : ${offer}"),
            // Text("duration : ${order.durationInDays}"),
            Text("accepted : ${offer.offerAccepted}"),
            Text("canceled : ${offer.offerCancelled}"),
            Text(
                "offerAcceptedTime : ${DateFormatter.toTime(offer.offerAcceptedTime ?? DateTime.now())}"),
            Text("offerCancelledTime : ${offer.offerCancelledTime}"),
          ]),
        ),
        const Divider()
      ]),
    );
  }
}
