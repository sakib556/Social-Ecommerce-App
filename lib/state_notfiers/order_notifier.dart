import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/helper/network_exceptions.dart';
import 'package:protibeshi_app/models/offer/offer.dart';
import 'package:protibeshi_app/models/order/order.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

class OrderNotifier extends StateNotifier<ApiState<String>> {
  OrderNotifier() : super(const ApiState.initial());
  Future<void> addNewOrder(OfferModel offer, BuildContext context) async {
    try {
      final presentTime = DateTime.now();
      bool orderEnded = false;
      DateTime deliveryTime = offer.pickupTime; 
      DateTime? orderCompletedTime;
      String orderId =
          "${FirebaseConstants.firebaseInstance.currentUser!.uid}${presentTime.millisecondsSinceEpoch}";
      if(offer.sellUpdateInformation!=null){
           deliveryTime = presentTime;
           orderEnded =true;
           orderCompletedTime = presentTime;
      }
      OrderModel orderModel = OrderModel(
          id: orderId,
          offerId: offer.id,
          orderStartedTime: presentTime,
          deliveryTime: deliveryTime,
          orderEnded: orderEnded,
          orderCompletedTime: orderCompletedTime
          );
      FirebaseConstants.orderCollection.doc(orderId).set(orderModel.toMap());

    offer.rentUpdateInformation!=null?
      EasyLoading.showSuccess("Order started!")
      : EasyLoading.showSuccess("Order ended!");
    } catch (e) {
      EasyLoading.showError("Something went wrong!");
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      errorPopup(err);
      print(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }

  Future<void> finishOrder(OrderModel? order, BuildContext context) async {
        try {
      order!.orderEnded = true;    
      order.orderCompletedTime = DateTime.now();
      FirebaseConstants.orderCollection.doc(order.id).update(order.toMap());
      EasyLoading.showSuccess("Order finished!");
    } catch (e) {
      EasyLoading.showError("Something went wrong!");
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
      errorPopup(err);
      print(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }
}

class GetOrderNotifier extends StateNotifier<ApiState<List<OrderModel>>> {
  GetOrderNotifier() : super(const ApiState.initial()) {
    getOrders();
  }

  // Future<List<QuerySnapshot<Map<String, dynamic>>>>? orderList;

  Future<void> getOrders() async {
    state = const ApiState.loading();
    try {
      List<OrderModel> _lists = [];
      var snap = FirebaseConstants.orderCollection
          .orderBy("orderStartedTime", descending: true)
          .get()
          .then((event) {
        if (event.docs.isNotEmpty) {
          _lists.clear();
          for (var element in event.docs) {
            _lists.add(OrderModel.fromMap(element.data()));
          }
        }
      });
      state = ApiState.loaded(data: _lists);
    } catch (e) {
      state = ApiState.error(
        error: NetworkExceptions.getErrorMessage(
          NetworkExceptions.getDioException(e),
        ),
      );
    }
  }
  // Comparator<BorrowPostModel> sortByLocation = (a, b) => a.locationCode.compareTo(b.locationCode);

}
