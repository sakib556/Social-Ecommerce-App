import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/models/listing/listing_model.dart';
import 'package:protibeshi_app/models/listing/sub_category/bike_model.dart';
import 'package:protibeshi_app/models/listing/sub_category/book_model.dart';
import 'package:protibeshi_app/providers/catgory_provider.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/service_builder.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/teaching_builder.dart';

class ListingBuilder  extends StatelessWidget{
   final Widget Function(BuildContext context, List<ListingModel> listings) builder;
  const ListingBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BookBuilder(builder: ((context, bookList) {
      final List<ListingModel> allList = [];
      bookList.map((book) {
        ListingModel list = ListingModel(
          listingId: book.id, 
          categoryId: book.categoryId, 
          subCategoryId: book.subCategoryId, 
          forRent: book.forRent);
        allList.add(list);
      }).toList();
      //  print("${userOffers.length} index of offerOnly");
      //BookBuilder(builder: ((context,bookList) {}))
      return BikeBuilder(builder: ((context, bikeList) {
        bikeList.map((bike) {
          ListingModel list2 =
              ListingModel(
          listingId: bike.id, 
          categoryId: bike.categoryId, 
          subCategoryId: bike.subCategoryId, 
          forRent: bike.forRent);
          allList.add(list2);
        }).toList();
        return ServiceBuilder(builder: ((context, servList) {
             servList.map((service) {
          ListingModel list3 =
              ListingModel(
          listingId: service.id, 
          categoryId: service.categoryId, 
          subCategoryId: service.subCategoryId, 
          forRent: service.forRent);
          allList.add(list3);
        }).toList();
        return TeachingBuilder(builder: ((context, skillList) {
             skillList.map((skill) {
          ListingModel list4 =
              ListingModel(
          listingId: skill.id, 
          categoryId: skill.categoryId, 
          subCategoryId: skill.subCategoryId, 
          forRent: skill.forRent);
          allList.add(list4);
        }).toList();
        print(" all : ${allList.length}");
        return builder(context,allList);
        }));
        }));
      }));
    }));
  }
}

class BookBuilder extends ConsumerWidget {
  final Widget Function(BuildContext context, List<BookModel> bookList) builder;
  const BookBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getBookProductProvider).maybeMap(
        orElse: () => Container(),
        error: (_) => Center(child: Text("error is: ${_.error}")),
        loaded: (list) {
          return builder(context, list.data);
        });
  }
}

class BikeBuilder extends ConsumerWidget {
  final Widget Function(BuildContext context, List<BikeModel> bookList) builder;
  const BikeBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getBikeProductProvider).maybeMap(
        orElse: () => Container(),
        error: (_) => Center(child: Text("error is: ${_.error}")),
        loaded: (list) {
          return builder(context, list.data);
        });
  }
}
