import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' ;
import 'package:protibeshi_app/models/notification/notification.dart';
import 'package:protibeshi_app/providers/notification_provider.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_offer_builder.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen(this.notifyList, {Key? key}) : super(key: key);
  final List<NotificationModel> notifyList;
  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {

  @override
  void initState() {
    ref.read(notificationProvider.notifier).seenNotification(widget.notifyList);
    print("called 1 \n");
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return UserOrdersBuilder(builder: ((context, userOffersList, orderList) {
      // final userOffers = userOffersList.where((offer) =>
      //               !offer.offerCancelled &&
      //                   offer.buyerId == FirebaseConstants.currentUserId &&
      //                   !offer.offerAccepted &&
      //                   offer.isPostOffer).toList();
      return widget.notifyList.isNotEmpty
          ? ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 150),
              children: widget.notifyList.map((notification) {
                return NotificationShow(notification: notification);
              }).toList())
          : const Center(
              child: Text("empty"),
            );
    }));
  }
  }


  class NotificationShow extends StatelessWidget{
  const NotificationShow({Key? key, required this.notification}) : super(key: key);
  final NotificationModel notification;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => PostRecievedOfferDetails(
        //             offer: offer,
        //           )),
        // );
      },
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text("id : ${notification.id}"),
            Text("receiverId : ${notification.receiverId}"),
            Text("isRead : ${notification.isRead}"),
            Text("offferId : ${notification.offferId}"),
            Text("orderId : ${notification.orderId}"),
            Text("readTime : ${notification.readTime}"),
            Text("sentTime : ${notification.sentTime}"),
         
          ]),
        ),
        const Divider()
      ]),
    );
  }
}


