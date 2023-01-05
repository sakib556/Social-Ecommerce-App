import 'package:flutter/material.dart';
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:protibeshi_app/themes/colors.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';
import 'package:protibeshi_app/views/tabs/home/components/offer/offer_third_page.dart';

class OfferSecondPage extends StatelessWidget {
  final BorrowPostModel borrowPostModel;
  const OfferSecondPage({
    Key? key,
    required this.borrowPostModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
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
                const SizedBox(height: 30),
                Row(
                  children: [
                    Flexible(
                        child: Container(
                      margin: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: 200,
                        child: Image.network(
                          'https://images.unsplash.com/photo-1647482770231-0efa17132429?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                    Flexible(
                        child: Container(
                      margin: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: 200,
                        child: Image.network(
                          'https://images.unsplash.com/photo-1607920592519-bab4d7db727d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                    Flexible(
                        child: Container(
                      margin: const EdgeInsets.all(5.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        dashPattern: const [6, 3, 6, 3],
                        radius: const Radius.circular(12),
                        child: SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_circle_outline,
                                  size: 40,
                                  color: MyColors.secondaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 30),
                const Divider(
                  thickness: 0.5,
                  color: MyColors.secondaryColor,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Category",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text("Household> Corkery",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: MyColors.goldColor))
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Name",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 20,
                              height: 2.0,
                              color: MyColors.secondaryColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: MyColors.lightBgColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: MyColors.lightBgColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Write Product Name",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      color:
                                          MyColors.blackColor.withOpacity(0.38),
                                    )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Details",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextField(
                            maxLines: 3,
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      fontSize: 16,
                                      height: 2.0,
                                      color: MyColors.secondaryColor,
                                    ),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: MyColors.lightBgColor,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: MyColors.lightBgColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText:
                                    "Easily gets scratched, need to handle with care",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      color:
                                          MyColors.blackColor.withOpacity(0.38),
                                    )),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: Text(
                              "please provide instruction to use the product",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: MyColors.secondaryColor),
                            )),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: "Next",
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
                  color: MyColors.greenColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
