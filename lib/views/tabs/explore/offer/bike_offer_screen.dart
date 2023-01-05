import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/date_formatter.dart';
import 'package:protibeshi_app/helper/get_geo_point.dart';
import 'package:protibeshi_app/models/listing/category/service_model.dart';
import 'package:protibeshi_app/models/listing/sub_category/bike_model.dart';
import 'package:protibeshi_app/models/listing/sub_category/book_model.dart';
import 'package:protibeshi_app/models/offer/offer.dart';
import 'package:protibeshi_app/models/offer/rent_update_information.dart';
import 'package:protibeshi_app/models/offer/sell_update_information.dart';
import 'package:protibeshi_app/providers/offer_provider.dart';
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';
import 'package:protibeshi_app/views/others/space_horizontal.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/tabs/dashboard/dashboard_screen.dart';
import 'package:protibeshi_app/views/tabs/profile/components/listings/bike.dart';

class BikeRentOfferScreen extends ConsumerStatefulWidget {
  final BikeModel bikeModel;
  final bool forRent;
  const BikeRentOfferScreen({
    Key? key,
    required this.forRent,
    required this.bikeModel,
  }) : super(key: key);

  @override
  ConsumerState<BikeRentOfferScreen> createState() =>
      _BikeRentOfferScreenState();
}

class _BikeRentOfferScreenState extends ConsumerState<BikeRentOfferScreen> {
  DateTimeRange _dateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 5)));
  DateTime _pickupTime = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                BikeView(
                  bike: widget.bikeModel,
                  fromCategoryPage: false,
                ),
                const SizedBox(height: 20),
                Divider(
                  thickness: 0.5,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                  //color: MyColors.secondaryColor,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Duration : ",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
                const SpaceVertical(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(.6),
                      //color: MyColors.secondaryColor,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showDateRangePicker(
                          context: context,
                          initialDateRange: _dateRange,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              _dateRange = value;
                            });
                          }
                        });
                      },
                      child: Text(
                          _dateRange.start.toString().split(' ')[0] +
                              ' to ' +
                              _dateRange.end.toString().split(' ')[0],
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(.6))),
                      //color: MyColors.secondaryColor)),
                    )
                  ],
                ),
                const SpaceVertical(20),
                Row(
                  children: [
                    Text("Total days : ",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SpaceHorizontal(10),
                    Text(
                      "${_dateRange.duration.inDays}",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(.40),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                //date time
                const SpaceVertical(20),
                Row(
                  children: [
                    Text("Cost 1st day : ",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SpaceHorizontal(10),
                    Text(
                      widget.bikeModel.costFirstDay,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(.40),
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(" Cost/extra day :",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SpaceHorizontal(10),
                    Text(
                      widget.bikeModel.costPerExtraDay,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(.40),
                          ),
                    ),
                  ],
                ),
                const SpaceVertical(20),
                //pickup time
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Pick-up Time :",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
                const SpaceVertical(10),
                GestureDetector(
                  onTap: () async {
                    await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_pickupTime),
                      initialEntryMode: TimePickerEntryMode.input,
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _pickupTime = join(_dateRange, value);
                        });
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(.6),
                        ),
                        const SpaceHorizontal(10),
                        Text(DateFormatter.toTime(_pickupTime),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.6)))
                      ],
                    ),
                  ),
                ),
                const SpaceVertical(20),
                CustomButton(
                  text: "Rent Request",
                  onPressed: () async {
                    final _geo = Geoflutterfire();
                    GeoPoint _location = const GeoPoint(0, 0);
                    _location = getGeoPointFromLocationModel(
                        UserLocations.homeLocation!);
                    GeoFirePoint _geoLocation = _geo.point(
                        latitude: _location.latitude,
                        longitude: _location.longitude);
                    String _locationName =
                        "${UserLocations.homeLocation!.house}, ${UserLocations.homeLocation!.street}, ${UserLocations.homeLocation!.area}";
                    String _offerId =
                        "${FirebaseConstants.firebaseInstance.currentUser!.uid}${DateTime.now().millisecondsSinceEpoch}";
                    RentUpdateInformation _updateInformation =
                        RentUpdateInformation(
                            startDate: _dateRange.start,
                            endDate: _dateRange.end,
                            durationInDays: _dateRange.duration.inDays,
                            lastUpdateTime: DateTime.now(),
                            updateInformations: [],
                            userMessages: [],
                            costFirstDay: widget.bikeModel.costFirstDay,
                            costPerExtraDay: widget.bikeModel.costPerExtraDay);
                    OfferModel _offerModel = OfferModel(
                        id: _offerId,
                        buyerId: FirebaseConstants.firebaseInstance.currentUser!.uid,
                        sellerId: widget.bikeModel.userId,
                        listingId: widget.bikeModel.id,
                        rentUpdateInformation: _updateInformation,
                        pickupLocationCode: _geoLocation.data,
                        pickupLocationName: _locationName,
                        pickupTime: _pickupTime,
                        offerSentTime: DateTime.now(),
                        isPostOffer: false);

                    await ref
                        .read(offerProvider.notifier)
                        .addNewOffer(_offerModel);
                    EasyLoading.showSuccess("sent!!");
                    Navigator.pop(context);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DashBoardScreen()));
                  },
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime join(DateTimeRange date, TimeOfDay time) {
    return DateTime(date.start.year, date.start.month, date.start.day,
        time.hour, time.minute);
  }
}

class BikeSellOfferScreen extends ConsumerStatefulWidget {
  final BikeModel bikeModel;
  final bool forRent;
  const BikeSellOfferScreen({
    Key? key,
    required this.forRent,
    required this.bikeModel,
  }) : super(key: key);

  @override
  ConsumerState<BikeSellOfferScreen> createState() =>
      _BikeSellOfferScreenState();
}

class _BikeSellOfferScreenState extends ConsumerState<BikeSellOfferScreen> {
  DateTime? _pickupTime;
  DateTime? _pickupDate;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("sell price is : ${widget.bikeModel.id}");
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                BikeView(
                  bike: widget.bikeModel,
                  fromCategoryPage: false,
                ),
                const SizedBox(height: 20),
                Divider(
                  thickness: 0.5,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                  //color: MyColors.secondaryColor,
                ),
                const SpaceVertical(20),
                Row(
                  children: [
                    Text("Sell price : ",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SpaceHorizontal(10),
                    Text(
                      widget.bikeModel.sellPrice,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(.40),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SpaceVertical(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Pick-up time :",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
                const SpaceVertical(10),
                GestureDetector(
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      initialDate:  DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _pickupDate = value;
                        });
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(.6),
                        ),
                        const SpaceHorizontal(10),
                        Text(DateFormatter.toTime(_pickupDate??DateTime.now()),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.6)))
                      ],
                    ),
                  ),
                ),
                const SpaceVertical(10),
                _pickupDate != null
                    ? GestureDetector(
                        onTap: () async {
                          await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                            initialEntryMode: TimePickerEntryMode.input,
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                _pickupTime =
                                    join(_pickupDate ?? DateTime.now(), value);
                              });
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(.6),
                              ),
                              const SpaceHorizontal(10),
                              Text(DateFormatter.toDMY(_pickupTime??DateTime.now()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(.6)))
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SpaceVertical(20),
                CustomButton(
                  text: "Sell Request",
                  onPressed: () async {
                    final _geo = Geoflutterfire();
                    GeoPoint _location = const GeoPoint(0, 0);
                    _location = getGeoPointFromLocationModel(
                        UserLocations.homeLocation!);
                    GeoFirePoint _geoLocation = _geo.point(
                        latitude: _location.latitude,
                        longitude: _location.longitude);
                    String _locationName =
                        "${UserLocations.homeLocation!.house}, ${UserLocations.homeLocation!.street}, ${UserLocations.homeLocation!.area}";
                    String _offerId =
                        "${FirebaseConstants.firebaseInstance.currentUser!.uid}${DateTime.now().millisecondsSinceEpoch}";
                    SellUpdateInformation _updateInformation =
                        SellUpdateInformation(
                            cost: widget.bikeModel.sellPrice,
                            lastUpdateTime: DateTime.now(),
                            updateInformations: [],
                            userMessages: []);
                    OfferModel _offerModel = OfferModel(
                        id: _offerId,
                        buyerId: FirebaseConstants.firebaseInstance.currentUser!.uid,
                        sellerId: widget.bikeModel.userId,
                        listingId: widget.bikeModel.id,
                        sellUpdateInformation: _updateInformation,
                        pickupLocationCode: _geoLocation.data,
                        pickupLocationName: _locationName,
                        pickupTime: _pickupTime ?? DateTime.now(),
                        offerSentTime: DateTime.now(),
                        isPostOffer: false);

                    await ref
                        .read(offerProvider.notifier)
                        .addNewOffer(_offerModel);
                    EasyLoading.showSuccess("sent!!");
                    Navigator.pop(context);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DashBoardScreen()));
                  },
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime join(DateTime date, TimeOfDay time) {
    return DateTime(
        date.year, date.month, date.day, time.hour, time.minute);
  }
}
