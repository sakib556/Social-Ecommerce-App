import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/get_geo_point.dart';
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:protibeshi_app/providers/post_provider.dart';
import 'package:protibeshi_app/state_notfiers/user_notfier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:protibeshi_app/views/tabs/home/components/borrow/create_borrow_post.dart';
import 'package:protibeshi_app/views/tabs/home/components/borrow/create_borrow_post_budget.dart';

class CreateBorrowPostPageView extends StatefulWidget {
  const CreateBorrowPostPageView({Key? key, this.borrowPost}) : super(key: key);
  final BorrowPostModel? borrowPost;
  @override
  _CreateBorrowPostPageViewState createState() =>
      _CreateBorrowPostPageViewState();
}

class _CreateBorrowPostPageViewState extends State<CreateBorrowPostPageView> {
  final PageController _pageController = PageController();
  final TextEditingController _postTextController = TextEditingController();
  final TextEditingController _budgetTextController = TextEditingController();
  final TextEditingController _subCategoryController = TextEditingController();

  DateTimeRange _dateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 1)));
  DateTime pickupTime = DateTime.now();

  final List<File> _selectedImages = [];
  final List<String> _imgLink = [];
  final List<String> _deleteImgLink = [];
  @override
  void initState() {
    print("initstate call");
    if (widget.borrowPost != null) {
      _postTextController.text = widget.borrowPost!.postText;
      widget.borrowPost!.postImages.map((e) => _imgLink.add(e)).toList();
      _dateRange = DateTimeRange(
          start: widget.borrowPost!.startDate,
          end: widget.borrowPost!.endDate
              .add(Duration(days: widget.borrowPost!.durationInDays)));
      print("${widget.borrowPost!.postImages.length} is length 1");
      print("${_imgLink.length} is length 2");
    }
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Create Post
          CreateBorrowPost(
            imgLink: _imgLink,
            deleteImgLink: _deleteImgLink,
            postController: _postTextController,
            selectedImages: _selectedImages,
            onPressedBack: () {
              Navigator.pop(context);
            },
            onPressedNext: () async {
              await showDateRangePicker(
                context: context,
                initialDateRange: _dateRange,
                firstDate: widget.borrowPost == null
                    ? DateTime.now()
                    : _dateRange.start,
                lastDate: DateTime(2100),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    _dateRange = value;
                  });
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn);
                }
              });
            },
          ),
          //Budget
          rp.Consumer(
            builder: ((context, ref, child) => CreateBorrowPostBudget(
                  postController: _postTextController,
                  selectedImages: _selectedImages,
                  imgLink: _imgLink,
                  deleteImgLink: _deleteImgLink,
                  dateTimeRange: _dateRange,
                  pickupTime: pickupTime,
                  budgetController: _budgetTextController,
                  onPressedNext: (int selectedLocationType) async {
                    GeoPoint _location = const GeoPoint(0, 0);
                    String _address = "";
                    if (selectedLocationType == 1) {
                      _location = getGeoPointFromLocationModel(
                          UserLocations.homeLocation!);
                      _address =
                          "${UserLocations.homeLocation!.house}, ${UserLocations.homeLocation!.street}, ${UserLocations.homeLocation!.area}";
                    } else if (selectedLocationType == 2) {
                      _location = getGeoPointFromLocationModel(
                          UserLocations.workLocation!);
                      _address =
                          "${UserLocations.workLocation!.house}, ${UserLocations.workLocation!.street}, ${UserLocations.workLocation!.area}";
                    } else {
                      _location = getGeoPointFromLocationModel(
                          UserLocations.userAllLocations.first);
                      _address =
                          "${UserLocations.userAllLocations.first.house}, ${UserLocations.userAllLocations.first.street}, ${UserLocations.userAllLocations.first.area}";
                    }
                    final _geo = Geoflutterfire();
                    GeoFirePoint _geoLocation = _geo.point(
                        latitude: _location.latitude,
                        longitude: _location.longitude);
                    Future<void> _createPost(List<String> postImages) async {
                      String _postId =
                          "${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().millisecondsSinceEpoch}";
                      if (_budgetTextController.text.isNotEmpty) {
                        BorrowPostModel _borrowPostModel = BorrowPostModel(
                          id: _postId,
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          locationCode: _geoLocation.data,
                          locationName: _address,
                          postImages: postImages,
                          postText: _postTextController.text.trim(),
                          postBudget: _budgetTextController.text.trim(),
                          durationInDays: _dateRange.duration.inDays,
                          postTime: DateTime.now(),
                          endDate: _dateRange.end,
                          startDate: _dateRange.start,
                          pickupTime: pickupTime,
                          subCategoryName: _subCategoryController.text,
                        );
                        if (_selectedImages.isEmpty) {
                          EasyLoading.show(status: "Posting...");
                        }
                        ref
                            .watch(borrowPostProvider.notifier)
                            .addNewBorrowPost(_borrowPostModel, context);
                      } else {
                        EasyLoading.showInfo("Please input your budget!");
                      }
                    }

                    Future<void> _updatePost(List<String> postImages) async {
                      if (_budgetTextController.text.isNotEmpty) {
                        BorrowPostModel _borrowPostModel = BorrowPostModel(
                          id: widget.borrowPost!.id,
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          locationCode: _geoLocation.data,
                          locationName: _address,
                          postImages: postImages,
                          postText: _postTextController.text.trim(),
                          postBudget: _budgetTextController.text.trim(),
                          durationInDays: _dateRange.duration.inDays,
                          postTime: widget.borrowPost!.postTime,
                          endDate: _dateRange.end,
                          startDate: _dateRange.start,
                          pickupTime: pickupTime,
                          subCategoryName: _subCategoryController.text,
                        );
                        if (_selectedImages.isEmpty) {
                          EasyLoading.show(status: "Posting...");
                        }
                        ref
                            .watch(borrowPostProvider.notifier)
                            .updateBorrowPost(_borrowPostModel, context);
                        ref
                            .read(getBorrowPostsProvider.notifier)
                            .allBorrowPosts();

                      } else {
                        EasyLoading.showInfo("Please input your budget!");
                      }
                    }

                    if (_selectedImages.isNotEmpty) {
                      FirebaseConstants.deleteFiles(
                              images: _deleteImgLink, fileName: "Post Images")
                          .then((value) async {
                        await FirebaseConstants.uploadFiles(
                                images: _selectedImages,
                                fileName: "Post Images")
                            .then((value) => 
                            widget.borrowPost == null
                          ? _createPost(value)
                          : _updatePost(value)
                            );
                      });
                    } else {
                      widget.borrowPost == null
                          ? _createPost([])
                          : _updatePost([]);
                    }
                  },
                  onPressedBack: () {
                    _pageController.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  },
                  subCategoryController: _subCategoryController,
                  borrowPost: widget.borrowPost,
                )),
          ),
        ],
      ),
    );
  }
}


  // Map startDate(DateTimeRange dateTimeRange) {
  //   return {
  //     'date': dateTimeRange.start.day,
  //     'month': dateTimeRange.start.month,
  //     'year': dateTimeRange.start.year,
  //   };
  // }

  // Map endDate(DateTimeRange dateTimeRange) {
  //   return {
  //     'date': dateTimeRange.end.day,
  //     'month': dateTimeRange.end.month,
  //     'year': dateTimeRange.end.year,
  //   };
  // }