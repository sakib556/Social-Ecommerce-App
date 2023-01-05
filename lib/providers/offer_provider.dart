import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/models/offer/offer.dart';
import 'package:protibeshi_app/state_notfiers/offer_notifier.dart';

final offerProvider =
    StateNotifierProvider<OfferNotifier, ApiState<String>>(
        (ref) => OfferNotifier());
final getOfferProvider =
    StateNotifierProvider<GetOfferNotifier, ApiState<List<OfferModel>>>(
        (ref) => GetOfferNotifier());
