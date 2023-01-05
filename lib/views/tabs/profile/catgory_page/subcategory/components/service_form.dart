import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/get_geo_point.dart';
import 'package:protibeshi_app/models/listing/category/service_model.dart';
import 'package:protibeshi_app/providers/catgory_provider.dart';
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_text_field.dart';
import 'package:protibeshi_app/views/custom_widgets/view_images.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/service_builder.dart';
import 'package:protibeshi_app/views/tabs/bottom_nav_bar_page.dart';
import 'package:protibeshi_app/views/tabs/profile/profile_screen.dart';

final skillDetailsController = TextEditingController();
final imageUrlController = TextEditingController();

class ServiceForm extends ConsumerWidget {
  const ServiceForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ServiceBuilder(builder: ((context, userServices) {
      bool forRent = false;
      bool forSell = false;
      bool isCostPerHour = false;
      bool isCostPerDay = true;
      int _index = 1;
      final userService = ref.watch(serviceItemProvider);
      // final isNew = userServices.isNotEmpty ? userServices
      //       .where(
      //           (service) => service.userId == FirebaseConstants.currentUserId)
      //       .toList():[];
      return Column(
        children: [
          ...userService
              .map((e) => ServiceTypeWidget(serviceTypeModel: e))
              .toList(),
          CustomButton(
              text: "Add listing",
              onPressed: () async {
                EasyLoading.show(status: "Uploading your services...");

                GeoPoint _location = const GeoPoint(0, 0);
                _location =
                    getGeoPointFromLocationModel(UserLocations.homeLocation!);
                final _geo = Geoflutterfire();
                GeoFirePoint _geoLocation = _geo.point(
                    latitude: _location.latitude,
                    longitude: _location.longitude);
                String _locationName =
                    "${UserLocations.homeLocation!.house}, ${UserLocations.homeLocation!.street}, ${UserLocations.homeLocation!.area}";
                String _id =
                    "${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().millisecondsSinceEpoch}";
                Future<void> _createPost(
                    ServiceInformationModel serviceInformation) async {
                  //  if (serviceInformation.selectedImages!.isNotEmpty || serviceInformation.selectedImages!=null ) {

                  String _postId = "$_id$_index";
                  _index++;
                  ServiceModel _serviceModel = ServiceModel(
                    subCategoryId: serviceInformation.serviceName,
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    categoryId: "Service",
                    creationTime: DateTime.now(),
                    id: _postId,
                    serviceInformation: serviceInformation,
                    available: true,
                    locationCode: _geoLocation.data,
                    locationName: _locationName,
                    forRent: forRent,
                    forSell: forSell,
                    costPerHour: '',
                    costFirstDay: '20 to 100tk',
                    originalPrice: '',
                    costPerExtraDay: '',
                    sellPrice: '',
                  );
                  print("read start");
                  await ref
                      .read(serviceProvider.notifier)
                      .addServiceListing(_serviceModel, context);
                  print("read done fe");
                }

                print("test 1");
                Future<void> _serviceUpload() async {
                  await Future.wait(userService.map((e) async {
                    print("test 2");
                    e.isSelected
                        ? await FirebaseConstants.uploadFiles(
                                images: e.selectedImages,
                                fileName: "${e.serviceName} Images")
                            .then((value) async {
                            e.imageUrl = value;
                            print("${value.length} link");
                            await _createPost(e);
                            print("post complete");
                          })
                        : print("Not selected");
                    print("test 3");
                  }));
                }

                print("test 4");
                await _serviceUpload();
                print("test last");
                EasyLoading.showSuccess("Your services added.");

                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const BottomNavBarPage(),
                //   ),
                // );
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const BottomNavBarPage()),
                  ModalRoute.withName('/'),
                );
              },
              color: Theme.of(context).colorScheme.primary)
        ],
      );
    }));
  }
}

class ServiceTypeWidget extends ConsumerWidget {
  const ServiceTypeWidget({Key? key, required this.serviceTypeModel})
      : super(key: key);
  final ServiceInformationModel serviceTypeModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CheckboxListTile(
          value: serviceTypeModel.isSelected,
          onChanged: (_) {
            ref.read(serviceItemProvider.notifier).toggle(serviceTypeModel);
          },
          title: Text(serviceTypeModel.serviceName),
        ),
        serviceTypeModel.isSelected
            ? Column(
                children: [
                  ViewImages(
                    selectedImages: serviceTypeModel.selectedImages,
                    onPressedBack: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SpaceVertical(20),
                  TextFieldWithHeading(
                    controller: serviceTypeModel.controller,
                    maxLines: 1,
                    hintText: "Details",
                    // onChanged: (value) {
                    ///  serviceTypeModel.serviceDetails = value;
                    // print("servicedetail: ${serviceTypeModel.serviceName}");
                    //  },
                  ),
                ],
              )
            : const SizedBox(),
        const SpaceVertical(10)
      ],
    );
  }
}
