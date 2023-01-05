import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/models/listing/category/service_model.dart';
import 'package:protibeshi_app/models/listing/category/teaching_model.dart';
import 'package:protibeshi_app/models/listing/sub_category/bike_model.dart';
import 'package:protibeshi_app/models/listing/sub_category/book_model.dart';
import 'package:protibeshi_app/models/listing/sub_category/home_made_food_model.dart';
import 'package:protibeshi_app/state_notfiers/listing_notifiers/bike_notifier.dart';
import 'package:protibeshi_app/state_notfiers/listing_notifiers/book_notifier.dart';
import 'package:protibeshi_app/state_notfiers/listing_notifiers/home_made_food_notifier.dart';
import 'package:protibeshi_app/state_notfiers/listing_notifiers/service_notifier.dart';
import 'package:protibeshi_app/state_notfiers/listing_notifiers/teaching_notifier.dart';

// product
final bookProductGenreProvider =
    StateNotifierProvider.autoDispose<BookGenreNotifier, List<CheckBoxModel>>(
        (ref) {
  return BookGenreNotifier();
});
final bookProductProvider =
    StateNotifierProvider<BookListNotifier, ApiState<String>>(
        (ref) => BookListNotifier());
final getBookProductProvider =
    StateNotifierProvider<GetBookListNotifier, ApiState<List<BookModel>>>(
        (ref) => GetBookListNotifier());

final homeMFoodProductGenreProvider =
    StateNotifierProvider.autoDispose<BookGenreNotifier, List<CheckBoxModel>>(
        (ref) {
  return BookGenreNotifier();
});
final homeMFoodProductProvider =
    StateNotifierProvider<HomeMadeFoodListNotifier, ApiState<String>>(
        (ref) => HomeMadeFoodListNotifier());
final gethomeMFoodProductProvider = StateNotifierProvider<
    GetHomeMadeFoodListNotifier,
    ApiState<List<HomeMadeFoodModel>>>((ref) => GetHomeMadeFoodListNotifier());

final bikeProductProvider =
    StateNotifierProvider<BikeProductNotifier, ApiState<String>>(
        (ref) => BikeProductNotifier());
final getBikeProductProvider =
    StateNotifierProvider<GetBikeProductNotifier, ApiState<List<BikeModel>>>(
        (ref) => GetBikeProductNotifier());

//service
// final serviceItemProviderOld =
//     StateNotifierProvider<ServiceItemNotifier, List<ServiceInformationModel>>(
//         (ref) => ServiceItemNotifier(ref.watch(getServiceItemProvider)));
final serviceItemProvider =
    StateNotifierProvider<ServiceItemNotifier, List<ServiceInformationModel>>(
        (ref) => ServiceItemNotifier());
final getServiceProvider =
    StateNotifierProvider<GetServiceListNotifier, ApiState<List<ServiceModel>>>(
        (ref) => GetServiceListNotifier());
final serviceProvider =
    StateNotifierProvider<ServiceListNotifier, ApiState<String>>(
        (ref) => ServiceListNotifier());
//teaching
final teachingItemProvider =
    StateNotifierProvider<TeachingItemNotifier, List<TeachingInformationModel>>(
        (ref) => TeachingItemNotifier());
final getTeachingProvider =
    StateNotifierProvider<GetTeachingListNotifier, ApiState<List<TeachingModel>>>(
        (ref) => GetTeachingListNotifier());
final teachingProvider =
    StateNotifierProvider<TeachingListNotifier, ApiState<String>>(
        (ref) => TeachingListNotifier());
// final getServiceItemProviderOld = Provider((ref) {
//   List<ServiceInformationModel> _list = [];
//   ref.watch(getServiceProvider).maybeMap(
//       orElse: () {print("error");},
//       loaded: (userServices) {
//         final currentUserService = userServices.data
//             .where(
//                 (service) => service.userId == FirebaseConstants.currentUserId)
//             .toList();
//         final List<ServiceInformationModel> userServiceItem =
//             currentUserService.isNotEmpty
//                 ? currentUserService.first.serviceInformation
//                 : serviceDefaultItems;
//         _list = userServiceItem;
//       });
//   return _list;
// });

class CheckBoxModel {
  CheckBoxModel(
      {required this.id, required this.title, required this.selected});
  final int id;
  final String title;
  bool selected;
}
