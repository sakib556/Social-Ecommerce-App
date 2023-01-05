import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/get_geo_point.dart';
import 'package:protibeshi_app/models/listing/sub_category/book_model.dart';
import 'package:protibeshi_app/providers/catgory_provider.dart';
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:protibeshi_app/views/custom_widgets/create_listing_budget.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_checkbox.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_text_field.dart';
import 'package:protibeshi_app/views/custom_widgets/price_textbox.dart';
import 'package:protibeshi_app/views/custom_widgets/view_images.dart';
import 'package:protibeshi_app/views/others/space_horizontal.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/components/condition_box.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/components/genres_box.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/subcategory/components/product_forms/form_helper.dart';

class BookForm extends ConsumerWidget {
  final String categoryName;
  final String subCategoryName;
  final BookModel? bookModel;
  const BookForm( 
      {this.bookModel,required this.categoryName, required this.subCategoryName, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genreValues = ref.watch(bookProductGenreProvider);
    bool forRent = false;
    bool forSell = false;
    bool isCostPerHour = false;
    bool isCostPerDay = true;
    return StatefulBuilder(builder: (context, _setState) {
      return Column(
        children: [
          Text(
            "Books",
            style: Theme.of(context).textTheme.headline4,
          ),
          const SpaceVertical(20),
          ViewImages(
            selectedImages: selectedImages,
            onPressedBack: () {
              Navigator.pop(context);
            },
          ),
          const SpaceVertical(20),
          TextFieldWithHeading(
              controller: nameController,
              heading: "Book Name",
              maxLines: 2,
              hintText: "Poems Book"),
          const SpaceVertical(20),
          TextFieldWithHeading(
              controller: bookAuthorController,
              heading: "Author",
              maxLines: 1,
              hintText: "Kazi Nazrul Islam"),
          const SpaceVertical(20),
          GenresBox(onTap: () {
            dialogueBox(context);
          }, title: 'Genres',),
          const SpaceVertical(5),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(20, 0, 16, 5),
            child: Wrap(
              children: [
                for (var value in genreValues)
                  value.selected
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.select_all_sharp),
                            Text(value.title),
                          ],
                        )
                      : const SizedBox(),
              ],
            ),
          ),
          const SpaceVertical(20),
          TextFieldWithHeading(
              controller: detailsController,
              heading: "Details",
              maxLines: 3,
              hintText: "This book is written by Kazi Nazrul Islam."),
          const SpaceVertical(20),
          ConditionBox(textController: conditionController),
          const SpaceVertical(10),
          Row(
            children: [
              CustomCheckbox(
                function: (value) {
                  _setState(() {
                    forRent = value;
                  });
                },
                isValue: forRent,
                title: 'Rent',
              ),
              CustomCheckbox(
                function: (value) {
                  _setState(() {
                    forSell = value;
                  });
                },
                isValue: forSell,
                title: 'Sell',
              ),
            ],
          ),
          const Divider(
            height: 10,
          ),
          forRent
              ? Column(
                  children: [
                    Row(
                      children: [
                        CustomCheckbox(
                          function: (value) {
                            _setState(() {
                              isCostPerDay = value;
                            });
                          },
                          isValue: isCostPerDay,
                          title: 'Cost/Day',
                        ),
                        const SpaceHorizontal(5),
                        CustomCheckbox(
                          function: (value) {
                            _setState(() {
                              isCostPerHour = value;
                            });
                          },
                          isValue: isCostPerHour,
                          title: 'Cost/Hour',
                        ),
                      ],
                    ),
                    PriceTextBox(
                        budgetController: originalPriceController,
                        hint: "",
                        title: "Original price : "),
                    isCostPerDay
                        ? Column(
                            children: [
                              CreateListingBudget(
                                  budgetController: costFirstDayController,
                                  title: "Cost of first day"),
                              CreateListingBudget(
                                  budgetController: costPerExtraDayController,
                                  title: "Cost per extra day"),
                            ],
                          )
                        : const SizedBox(),
                    isCostPerHour
                        ? CreateListingBudget(
                            budgetController: costPerHourController,
                            title: "Cost/hour")
                        : const SizedBox(),
                  ],
                )
              : const SizedBox(),
          forSell
              ? PriceTextBox(
                  budgetController: sellPriceController,
                  hint: "",
                  title: "Sell price : ")
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
            child: CustomButton(
                text: "next",
                onPressed: () async {
                  String _postId =
                      "${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().millisecondsSinceEpoch}";
                 if (forSell && !forRent) {
                    originalPriceController.text = sellPriceController.text;
                    costFirstDayController.text = sellPriceController.text;
                  }

                  if (nameController.text.isNotEmpty &&
                          detailsController.text.isNotEmpty &&
                          conditionController.text.isNotEmpty &&
                          bookAuthorController.text.isNotEmpty &&
                          costFirstDayController.text.isNotEmpty &&
                          originalPriceController.text.isNotEmpty &&
                          costPerExtraDayController.text.isNotEmpty ||
                      costPerHourController.text.isNotEmpty ||
                      sellPriceController.text.isNotEmpty &&
                          selectedImages.isNotEmpty) {

                    GeoPoint _location = const GeoPoint(0, 0);
                    _location = getGeoPointFromLocationModel(
                        UserLocations.homeLocation!);
                    final _geo = Geoflutterfire();
                    GeoFirePoint _geoLocation = _geo.point(
                        latitude: _location.latitude,
                        longitude: _location.longitude);
                    String _locationName =
                        "${UserLocations.homeLocation!.house}, ${UserLocations.homeLocation!.street}, ${UserLocations.homeLocation!.area}";
                    Future<void> _createPost(List<String> postImages) async {
                      BookModel _bookModel = BookModel(
                        subCategoryId: subCategoryName,
                        title: nameController.text.trim(),
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        categoryId: categoryName,
                        details: detailsController.text.trim(),
                        imageUrl: postImages,
                        creationTime: DateTime.now(),
                        id: _postId,
                        bookAuthor: bookAuthorController.text.trim(),
                        genres: selectedGenres,
                        available: true,
                        locationCode: _geoLocation.data,
                        locationName: _locationName,
                        forRent: forRent,
                        costFirstDay: costFirstDayController.text,
                        costPerExtraDay: costPerExtraDayController.text,
                        costPerHour: costPerHourController.text,
                        sellPrice: sellPriceController.text,
                        forSell: forSell,
                        originalPrice: originalPriceController.text,
                        condition: conditionController.text,
                      );

                      if (selectedImages.isEmpty) {
                        EasyLoading.show(status: "Posting...");
                      }
                      await ref
                          .watch(bookProductProvider.notifier)
                          .addBookListing(_bookModel, context);
                      ref.read(getBookProductProvider.notifier).allBookList();    
                    }

                    if (selectedImages.isNotEmpty) {
                      FirebaseConstants.uploadFiles(images:selectedImages,fileName:"Book Images").then((value) async {
                        _createPost(value);
                        clearAll();
                        Navigator.pop(context);
                      });
                    } else {
                      _createPost([]);
                    }
                    // Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: (context) =>
                    //                       const ProfileScreen()),
                    //             );
                  } else {
                    EasyLoading.showInfo("Please fill all the fields!");
                  }
                },
                color: Theme.of(context).colorScheme.primary),
          ),
        ],
      );
    });
  }

  Future dialogueBox(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Consumer(builder: (context, ref, _) {
          final genreValue = ref.watch(bookProductGenreProvider);
          return AlertDialog(
            title: const Text('Genre list'),
            content: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    for (final value in genreValue)
                      CheckboxListTile(
                        value: value.selected,
                        onChanged: (_) {
                          ref
                              .read(bookProductGenreProvider.notifier)
                              .toggle(value);
                        },
                        title: Text(value.title),
                      ),
                  ],
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  ref.read(bookProductGenreProvider.notifier).clearAll();
                  selectedGenres.clear();
                  Navigator.pop(context);
                },
                child: const Text('Clear All'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  selectedGenres.clear();
                  for (final value in genreValue) {
                    if (value.selected) selectedGenres.add(value.title);
                  }
                },
                child: const Text('Done'),
              ),
            ],
          );
        });
      },
    );
  }
}
