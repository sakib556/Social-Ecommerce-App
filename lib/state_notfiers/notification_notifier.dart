import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/helper/network_exceptions.dart';
import 'package:protibeshi_app/models/notification/notification.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

class NotificationNotifier extends StateNotifier<ApiState<String>> {
  NotificationNotifier() : super(const ApiState.initial());
  Future<void> addNotification(NotificationModel notifyModel) async {
    try {
      FirebaseConstants.notificationCollection
          .doc(notifyModel.id)
          .set(notifyModel.toMap());
      EasyLoading.showSuccess("notify sent!");
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

  Future<void> seenNotification(List<NotificationModel> notificationList)async {
    try {
      final list = notificationList.where((element) => !element.isRead).toList();
      for(var notifyModel in list ){
         NotificationModel notificationModel = NotificationModel(
          id: notifyModel.id,
          offferId: notifyModel.offferId,
          orderId: notifyModel.orderId,
          receiverId: notifyModel.receiverId,
          isRead: true,
          sentTime: notifyModel.sentTime,
          readTime: DateTime.now());
         FirebaseConstants.notificationCollection
           .doc(notificationModel.id)
           .update(notificationModel.toMap());
      }
      
      
      EasyLoading.showSuccess("seen");
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

class GetNotificationNotifier
    extends StateNotifier<ApiState<List<NotificationModel>>> {
  GetNotificationNotifier() : super(const ApiState.initial()) {
    getNotifications();
  }

  // StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? streamSubscription;

  Future<void> getNotifications() async {
    state = const ApiState.loading();
    try {
      List<NotificationModel> _lists = [];
      FirebaseConstants.notificationCollection
          .where("receiverId", isEqualTo: FirebaseConstants.firebaseInstance.currentUser!.uid)
          .orderBy("sentTime", descending: true)
          .snapshots()
          .listen((event) {
            print("object 1");
        if (event.docs.isNotEmpty) {
          _lists.clear();
          for (var element in event.docs) {
            _lists.add(NotificationModel.fromMap(element.data()));
          }
          print("${_lists.length}");
        }
        state = ApiState.loaded(data: _lists);
      });
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
