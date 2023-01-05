import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:protibeshi_app/models/listing/category/service_model.dart';
import 'package:protibeshi_app/models/listing/sub_category/book_model.dart';
import 'package:protibeshi_app/models/notification/notification.dart';
import 'package:protibeshi_app/models/offer/offer.dart';
import 'package:protibeshi_app/models/offer/rent_update_information.dart';
import 'package:protibeshi_app/providers/notification_provider.dart';
import 'package:protibeshi_app/providers/offer_provider.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/tabs/explore/offer/book_offer_screen.dart';
import 'package:protibeshi_app/views/custom_widgets/item_card.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/category_screen.dart';

class ServiceShowcase extends StatelessWidget {
  final List<ServiceModel> serviceList;
  final bool fromCategoryPage;
  final BorrowPostModel? borrowPost;
  final bool myServices;

  const ServiceShowcase(
      {Key? key,
      required this.serviceList,
      required this.fromCategoryPage,
      this.borrowPost,
      required this.myServices})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // void _onPressedSeeAll() {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => BooksForm(
    //         categoryName: , subCategoryName: subCategoryName)));
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Services",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
              ),
              myServices
                  ? TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CategoryScreen()),
                        );
                      },
                      child: const Icon(Icons.add),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        ServiceList(
          services: serviceList,
          fromCategoryPage: fromCategoryPage,
          borrowPost: borrowPost,
        )
      ],
    );
  }
}

class ServiceList extends StatelessWidget {
  final List<ServiceModel> services;
  final bool fromCategoryPage;
  final BorrowPostModel? borrowPost;

  const ServiceList(
      {Key? key,
      required this.services,
      required this.fromCategoryPage,
      this.borrowPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return services.isNotEmpty
        ? SizedBox(
            height: 220.0,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                ...services.map((service) {
                  return ServiceView(
                    borrowPost: borrowPost,
                    service: service,
                    fromCategoryPage: fromCategoryPage,
                  );
                }).toList(),
              ],
            ))
        : const Center(child: Text("No services in listing"));
  }
}

class ServiceView extends StatelessWidget {
  final ServiceModel service;
  final bool fromCategoryPage;
  final BorrowPostModel? borrowPost;
  const ServiceView(
      {Key? key,
      required this.service,
      required this.fromCategoryPage,
      this.borrowPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final colorSceme = Theme.of(context).colorScheme;
    return ItemCard(
        imageUrl: "https://image.shutterstock.com/image-illustration/person-icon-illustration-trendy-flat-260nw-2074006796.jpg",
        title: service.serviceInformation.serviceName,
        details: service.serviceInformation.serviceDetails ?? "No details",
        onTapped: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => ServiceDetails(
          //             service: service,
          //             fromCategoryPage: fromCategoryPage,
          //             borrowPost: borrowPost,
          //           )),
          // );
        });
  }
}

// class ServiceDetails extends ConsumerWidget {
//   final ServiceModel service;
//   final bool fromCategoryPage;
//   final BorrowPostModel? borrowPost;
//   const ServiceDetails({
//     Key? key,
//     this.borrowPost,
//     required this.service,
//     required this.fromCategoryPage,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(10),
//           child: Column(children: [
//             Text(service.serviceInformation.serviceName),
//             const SpaceVertical(10),
//             Text(service.serviceInformation.serviceDetails ?? "No details"),
//             const SpaceVertical(10),
//             Text(service.creationTime.day.toString()),
//             const SpaceVertical(10),
//             Text(service.locationCode.toString()),
//             const SpaceVertical(10),
//              fromCategoryPage
//                 ? Column(
//                     children: [
//                       service.forRent
//                           ? ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => ServiceRentOfferScreen(
//                                             bikeModel: bike,
//                                             forRent: true,
//                                           )),
//                                 );
//                               },
//                               child: const Text("Bike for rent"))
//                           : const SizedBox(),
//                       const SpaceVertical(5),
//                       bike.forSell
//                           ? ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => BikeSellOfferScreen(
//                                             bikeModel: bike,
//                                             forRent: false,
//                                           )),
//                                 );
//                               },
//                               child: const Text("Bike for sell"))
//                           : const SizedBox(),
//                     ],
//                   )
//                 : borrowPost != null
//                     ? ElevatedButton(
//                         onPressed: () async {
//                           String _offerId =
//                               "${FirebaseConstants.currentUserId}${DateTime.now().millisecondsSinceEpoch}";
//                           RentUpdateInformation _updateInformation =
//                               RentUpdateInformation(
//                                   costFirstDay: bike.costFirstDay,
//                                   costPerExtraDay: bike.costPerExtraDay,
//                                   startDate: borrowPost!.startDate,
//                                   endDate: borrowPost!.endDate,
//                                   durationInDays: borrowPost!.durationInDays,
//                                   lastUpdateTime: DateTime.now(),
//                                   updateInformations: [],
//                                   userMessages: []);
//                           OfferModel _offerModel = OfferModel(
//                               id: _offerId,
//                               buyerId: borrowPost!.userId,
//                               sellerId: FirebaseConstants.currentUserId,
//                               listingId: bike.id,
//                               rentUpdateInformation: _updateInformation,
//                               pickupLocationCode: bike.locationCode,
//                               pickupLocationName: bike.locationName,
//                               pickupTime: borrowPost!.pickupTime,
//                               postId: borrowPost!.id,
//                               offerSentTime: DateTime.now(),
//                               isPostOffer: !fromCategoryPage);
//                           await ref
//                               .read(offerProvider.notifier)
//                               .addNewOffer(_offerModel);
//                           String _notifyId =
//                               "${FirebaseConstants.currentUserId}${DateTime.now().millisecondsSinceEpoch}";
//                           NotificationModel notifyModel = NotificationModel(
//                               id: _notifyId,
//                               offferId: _offerId,
//                               receiverId: borrowPost!.userId,
//                               isRead: false,
//                               sentTime: DateTime.now());
//                           await ref
//                               .read(notificationProvider.notifier)
//                               .addNotification(notifyModel);
//                           EasyLoading.showSuccess("sent!!");
//                           Navigator.pop(context);
//                         },
//                         child: const Text("Sent offer"))
//                     : const SizedBox()
//           ]),
//         ),
//       ),
//     );
//   }
// }
