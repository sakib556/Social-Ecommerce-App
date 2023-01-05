import 'dart:io';

import 'package:flutter/material.dart';
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';
import 'package:protibeshi_app/views/custom_widgets/view_images.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/tabs/home/components/offer/offer_third_page.dart';

final TextEditingController _productNameController = TextEditingController();
final TextEditingController _productDetailsController = TextEditingController();
final List<File> _productImages = [];
// final List<String> _selectedGenres = [];

class OfferPage extends StatelessWidget {
  final BorrowPostModel borrowPostModel;
  const OfferPage({
    Key? key,
    required this.borrowPostModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Product Details",
                      maxLines: null,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SpaceVertical(30),
                ViewImages(
                    onPressedBack: () {
                      Navigator.pop(context);
                    },
                    selectedImages: _productImages),
                const SpaceVertical(30),
                const Divider(
                  thickness: 0.5,
                ),
                const SpaceVertical(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Category",
                        style: Theme.of(context).textTheme.headline6),
                    Text("Household> Corkery",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: const Color(0XFFE98F1A)))
                  ],
                ),
                const SpaceVertical(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Product Name",
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(.7),
                                    )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 52,
                          child: TextField(
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              height: 2.0,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(.6),
                              //  color: MyColors.secondaryColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(16, 5, 0, 5),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.4),
                                    // color: MyColors.lightBgColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.4),
                                    // color: MyColors.lightBgColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Wooden chair",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(.4),
                                      // MyColors.blackColor.withOpacity(0.38),
                                    )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SpaceVertical(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Details",
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.7),
                                  ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 52,
                          child: TextField(
                            maxLines: 3,
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      fontSize: 16,
                                      height: 2.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(.6),
                                      // color: MyColors.secondaryColor,
                                    ),
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.4),
                                    // color: MyColors.lightBgColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.4),
                                    // color: MyColors.lightBgColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText:
                                    "Easily gets scratched, need to handle with care",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(.4),
                                      // color:
                                      //     MyColors.blackColor.withOpacity(0.38),
                                    )),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Text(
                                "Please provide instruction to use the\nproduct",
                                // textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(.4),
                                    )
                                // .copyWith(color: MyColors.secondaryColor),
                                )),
                      ],
                    )
                  ],
                ),
                const SpaceVertical(30),
                CustomButton(
                    text: "next",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OfferThirdPage(
                            borrowPostModel: borrowPostModel,
                          ),
                        ),
                      );
                    },
                    color: Theme.of(context).colorScheme.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
