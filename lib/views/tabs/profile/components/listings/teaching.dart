import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:protibeshi_app/models/listing/category/teaching_model.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/custom_widgets/item_card.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/category_screen.dart';

class TeachingShowcase extends StatelessWidget {
  final List<TeachingModel> serviceList;
  final bool fromCategoryPage;
  final BorrowPostModel? borrowPost;
  final bool myServices;

  const TeachingShowcase(
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
                  "Skills",
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
        TeachingList(
          services: serviceList,
          fromCategoryPage: fromCategoryPage,
          borrowPost: borrowPost,
        )
      ],
    );
  }
}

class TeachingList extends StatelessWidget {
  final List<TeachingModel> services;
  final bool fromCategoryPage;
  final BorrowPostModel? borrowPost;

  const TeachingList(
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
                  return TeachingView(
                    borrowPost: borrowPost,
                    service: service,
                    fromCategoryPage: fromCategoryPage,
                  );
                }).toList(),
              ],
            ))
        : const Center(child: Text("No books in listing"));
  }
}

class TeachingView extends StatelessWidget {
  final TeachingModel service;
  final bool fromCategoryPage;
  final BorrowPostModel? borrowPost;
  const TeachingView(
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
        title: service.teachingInformation.serviceName,
        details: service.teachingInformation.serviceDetails ?? "No details",
        onTapped: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TeachingDetails(
                      service: service,
                      fromCategoryPage: fromCategoryPage,
                      borrowPost: borrowPost,
                    )),
          );
        });
  }
}

class TeachingDetails extends ConsumerWidget {
  final TeachingModel service;
  final bool fromCategoryPage;
  final BorrowPostModel? borrowPost;
  const TeachingDetails({
    Key? key,
    this.borrowPost,
    required this.service,
    required this.fromCategoryPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Text(service.teachingInformation.serviceName),
            const SpaceVertical(10),
            Text(service.teachingInformation.serviceDetails ?? "No details"),
            const SpaceVertical(10),
            Text(service.creationTime.day.toString()),
            const SpaceVertical(10),
            Text(service.locationCode.toString()),
            const SpaceVertical(10),
          ]),
        ),
      ),
    );
  }
}
