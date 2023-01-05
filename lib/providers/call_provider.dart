import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/models/call/call.dart';
import 'package:protibeshi_app/state_notfiers/call_notifier.dart';

final callProvider =
    StateNotifierProvider<CallNotifier, ApiState<String>>(
        (ref) => CallNotifier());
final getCallProvider =
    StateNotifierProvider<GetCallNotifier, ApiState<List<CallModel>>>(
        (ref) => GetCallNotifier());



