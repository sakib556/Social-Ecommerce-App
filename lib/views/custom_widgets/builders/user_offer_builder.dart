import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/models/offer/offer.dart';
import 'package:protibeshi_app/models/order/order.dart';
import 'package:protibeshi_app/providers/offer_provider.dart';
import 'package:protibeshi_app/providers/order_provider.dart';
import 'package:protibeshi_app/views/other_pages/loading.dart';
import 'package:protibeshi_app/views/other_pages/something_went_wrong.dart';

class UserOrdersBuilder extends ConsumerWidget {
  final Widget Function(BuildContext context, List<OfferModel> offerModel,
      List<OrderModel> orderModel) builder;

  const UserOrdersBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getOfferProvider).maybeMap(
        orElse: () => const Loading(),
        error: (_) => const SomethingWentWrong(),
        loaded: (offers) {
          final userOffers = offers.data
              .where((offer) =>
                  offer.buyerId == FirebaseConstants.firebaseInstance.currentUser!.uid ||
                  offer.sellerId == FirebaseConstants.firebaseInstance.currentUser!.uid)
              .toList();
          return ref.watch(getOrderProvider).maybeMap(
              orElse: () => const Loading(),
              error: (_) => const SomethingWentWrong(),
              loaded: (orders) {
                return builder(context, userOffers, orders.data);
              });
        });
  }
}

class UserOfferBuilder extends ConsumerWidget {
  final Widget Function(BuildContext context, List<OfferModel> offerModel)
      builder;
  const UserOfferBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserOrdersBuilder(builder: ((context, userOffersList, orderList) {
      final List<OfferModel> userOffers = [];
      // userOffersList.map((offer) {
      //   final userOrder = orderList.firstWhere(
      //       (orders) => orders.offerId == offer.id,
      //       orElse: () => OrderModel.emptyOrder());
      //   userOrder.id.isNotEmpty ? userOffers.add(offer) : null;
      // });
      print("${userOffers.length} index of offers");
      return builder(context, userOffers);
    }));
  }
}
