import 'package:flutter/material.dart';
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:protibeshi_app/themes/colors.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_dotted_border.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';

class OfferThirdPage extends StatefulWidget {
  final BorrowPostModel borrowPostModel;
  const OfferThirdPage({
    Key? key,
    required this.borrowPostModel,
  }) : super(key: key);

  @override
  State<OfferThirdPage> createState() => _OfferThirdPageState();
}

class _OfferThirdPageState extends State<OfferThirdPage> {
  DateTimeRange _dateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 5)));

  TextEditingController _custom = TextEditingController();

  @override
  void dispose() {
    _custom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
            // color: Colors.black, //change your color here
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
                      "Wooden Chair",
                      maxLines: null,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "An implicit animation widget that flips from one number to another, with support for customize styles, decimals and negative values. ",
                  maxLines: null,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(.6)
                      //color: MyColors.secondaryColor
                      ),
                ),
                const SizedBox(height: 20),
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
                            child: CustomDottedBorder(
                                iconSize: 40,
                                hasText: false,
                                onPressed: () {}))),
                  ],
                ),
                const SpaceVertical(20),
                Divider(
                  thickness: 0.5,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                  //color: MyColors.secondaryColor,
                ),
                const SpaceVertical(20),
                //location
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: Text("Location",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(.6)
                                  //color: MyColors.secondaryColor
                                  )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(.6)),
                            //color: MyColors.secondaryColor),
                          ),
                          child: Text(
                            "Home",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.6)),
                            //color: MyColors.secondaryColor),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(.6)),
                            //color: MyColors.secondaryColor),
                          ),
                          child: Text(
                            "Work",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.6)),
                            //color: MyColors.secondaryColor),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(.6)),
                            //color: MyColors.secondaryColor),
                          ),
                          child: Text(
                            "Custom",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.6)),
                            //color: MyColors.secondaryColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Category",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(.6)),
                      //color: MyColors.secondaryColor),
                    ),
                    Text("Household> Corkery",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: MyColors.goldColor))
                  ],
                ),
                const SizedBox(height: 20),
                Divider(
                  thickness: 0.5,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                  //color: MyColors.secondaryColor,
                ),
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
                              ' - ' +
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
                //date time
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Price/ day",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(.2),
                        //color: MyColors.lightBgColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text("50"),
                    ),
                    Container(
                      padding: const EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(.2),
                        //color: MyColors.lightBgColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text("100"),
                    ),
                    Container(
                      padding: const EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(.2),
                        //color: MyColors.lightBgColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text("200"),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                          controller: _custom,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Other",
                          ),
                        ))
                  ],
                ),
                //price per day
                const SizedBox(height: 20),
                CustomButton(
                  text: "done",
                  onPressed: () {},
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
