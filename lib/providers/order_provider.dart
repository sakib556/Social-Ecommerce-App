import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/models/order/order.dart';
import 'package:protibeshi_app/state_notfiers/order_notifier.dart';

final orderProvider =
    StateNotifierProvider<OrderNotifier, ApiState<String>>(
        (ref) => OrderNotifier());
final getOrderProvider =
    StateNotifierProvider<GetOrderNotifier, ApiState<List<OrderModel>>>(
        (ref) => GetOrderNotifier());
