// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:protibeshi_app/helper/date_formatter.dart';
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:protibeshi_app/models/user/location_model.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_location_builder.dart';
import 'package:protibeshi_app/views/others/space_horizontal.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/tabs/home/components/create_new_post_name_section.dart';

class CreateBorrowPostBudget extends StatefulWidget {
  final DateTimeRange dateTimeRange;
  final Function(int selectedLocationType) onPressedNext;
  final VoidCallback onPressedBack;
  final TextEditingController budgetController;
  final TextEditingController subCategoryController;
  final TextEditingController postController;
  DateTime pickupTime;
  BorrowPostModel? borrowPost;
  final List<File>? selectedImages;
  final List<String> imgLink;
  final List<String> deleteImgLink;
  CreateBorrowPostBudget({
    Key? key,
    required this.dateTimeRange,
    required this.onPressedNext,
    required this.onPressedBack,
    required this.budgetController,
    required this.subCategoryController,
    required this.postController,
    required this.pickupTime,
    required this.borrowPost,
    this.selectedImages,
    required this.imgLink,
    required this.deleteImgLink,
  }) : super(key: key);

  @override
  _CreateBorrowPostBudgetState createState() => _CreateBorrowPostBudgetState();
}

class _CreateBorrowPostBudgetState extends State<CreateBorrowPostBudget> {
  double _totalBudget = 0;
  int _selectedBudget = 0;
  int _selectedLocation = 1;
  double _otherBudget = 0;

  @override
  void initState() {
    if(widget.borrowPost!=null){
       _selectedBudget = -1;
    _otherBudget = double.parse(widget.borrowPost!.postBudget);
    widget.pickupTime= widget.borrowPost!.pickupTime; 
    }
    super.initState();
  }
  // final DateTimeRange _dateRange = DateTimeRange(
  //     start: DateTime.now(), end: DateTime.now().add(const Duration(days: 5)));
  final TextEditingController _otherBudgetController = TextEditingController();
  // final TextEditingController _subCategoryName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    widget.subCategoryController.text="Book";
    widget.budgetController.text = _selectedBudget == -1
        ? _otherBudget.toString()
        : _defaultBudgets[_selectedBudget].toString();
    _totalBudget = widget.budgetController.text.isNotEmpty
        ? double.parse(widget.budgetController.text) *
            widget.dateTimeRange.duration.inDays
        : 0;
    return WillPopScope(
      onWillPop: () async {
        widget.onPressedBack();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SpaceVertical(16),
                      const CretePostNameSection(),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          widget.postController.text,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      _createNewPostImageSection(context),
                    ],
                  ),
                ),
              ),
              const SpaceVertical(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const LightColorTextWidget(
                        text: "Location",
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              UserLocationBuilder(builder: (context, location) {
                                LocationModel? _home;
                                LocationModel? _work;

                                if (location.isNotEmpty) {
                                  for (var l in location) {
                                    if (l.locationType == 1) {
                                      _home = l;
                                    } else if (l.locationType == 2) {
                                      _work = l;
                                    }
                                  }
                                }

                                return Row(
                                  children: [
                                    if (_home != null)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedLocation =
                                                _home!.locationType;
                                          });
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: _selectedLocation ==
                                                          _home.locationType
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withOpacity(.1))),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                          child: Text(
                                            "Home",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                  color: _selectedLocation ==
                                                          _home.locationType
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withOpacity(0.4),
                                                ),
                                          ),
                                        ),
                                      ),
                                    if (_work != null)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedLocation =
                                                _work!.locationType;
                                          });
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: _selectedLocation ==
                                                          _work.locationType
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withOpacity(.1))),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                          child: Text(
                                            "Work",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                  color: _selectedLocation ==
                                                          _work.locationType
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withOpacity(0.4),
                                                ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              }),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedLocation = -1;

                                    //TODO: Add Custom location

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => MapPage(
                                    //       locationType: DateTime.now()
                                    //           .millisecondsSinceEpoch,
                                    //     ),
                                    //     fullscreenDialog: true,
                                    //   ),
                                    // );
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: _selectedLocation == -1
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(.1))),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Text(
                                    "Custom",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            color: _selectedLocation == -1
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withOpacity(.4)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
              const SpaceVertical(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:   [
                       const LightColorTextWidget(
                        text: "SubCategory",
                      ),
                      Text(widget.subCategoryController.text)
                    ]),
              ),
              const SpaceVertical(16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color:
                          Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                      //color: MyColors.secondaryColor,
                    ),
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
                        initialTime: 
                        widget.borrowPost==null?
                        TimeOfDay.fromDateTime(DateTime.now())
                        : TimeOfDay.fromDateTime(widget.pickupTime),
                        initialEntryMode: TimePickerEntryMode.input,
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            widget.pickupTime = join(widget.dateTimeRange, value);
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
                          Text(DateFormatter.toTime(widget.pickupTime),
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
                 
                  ],
                ),
              ),
              const Divider(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budget/day",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SpaceVertical(16),
                    Row(
                      children: [
                        for (var item in _defaultBudgets)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedBudget = _defaultBudgets.indexOf(item);
                                _otherBudgetController.clear();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: _selectedBudget ==
                                            _defaultBudgets.indexOf(item)
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(.1)),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                item.toInt().toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        color: _selectedBudget ==
                                                _defaultBudgets.indexOf(item)
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(.4)),
                              ),
                            ),
                          ),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: _otherBudgetController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.1),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.1),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Other",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(.4),
                                    )),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedBudget = -1;
                                if (value.isNotEmpty) {
                                  _otherBudget = double.parse(value);
                                } else {
                                  _otherBudget = 0;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SpaceVertical(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const LightColorTextWidget(
                        text: "Total Time",
                      ),
                      LightColorTextWidget(
                          opacity: 1,
                          text: widget.dateTimeRange.duration.inDays > 1
                              ? "${widget.dateTimeRange.duration.inDays} days"
                              : "${widget.dateTimeRange.duration.inDays} day"),
                    ]),
              ),
              const SpaceVertical(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const LightColorTextWidget(
                        text: "Total Cost",
                      ),
                      LightColorTextWidget(
                          opacity: 1, text: "${_totalBudget.toInt()} taka"),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          widget.onPressedBack();
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: const Text("Back")),
                    const SpaceHorizontal(8),
                    ElevatedButton(
                        onPressed: () {
                          widget.onPressedNext(_selectedLocation);
                        },
                        child: const Text("POST")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  DateTime join(DateTimeRange date, TimeOfDay time) {
  return  DateTime(date.start.year, date.start.month, date.start.day, time.hour, time.minute);
}
  Widget _createNewPostImageSection(BuildContext context) {
    return Column(
      children: [
           Wrap(
          children: widget.imgLink.map((e) {
            return SizedBox(
              width: widget.imgLink.length > 1
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.network(e, fit: BoxFit.cover),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.imgLink
                              .removeAt(widget.imgLink.indexOf(e));
                          widget.deleteImgLink.add(e);    
                        });
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
   
        widget.selectedImages != null
            ? Wrap(
                children: widget.selectedImages!.map((e) {
                  return SizedBox(
                    width: widget.selectedImages!.length > 1
                        ? MediaQuery.of(context).size.width / 2
                        : MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.file(
                            e,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.selectedImages!
                                    .removeAt(widget.selectedImages!.indexOf(e));
                              });
                            },
                            icon: const Icon(Icons.cancel),
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              )
            : Container(),
      ],
    );
  }
}

class LightColorTextWidget extends StatelessWidget {
  final String text;
  final double opacity;
  const LightColorTextWidget({
    Key? key,
    required this.text,
    this.opacity = 0.38,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(opacity),
          ),
    );
  }
}

List<double> _defaultBudgets = [
  50,
  100,
  200,
];
