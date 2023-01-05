import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/providers/catgory_provider.dart';
import 'package:protibeshi_app/themes/images.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/listing_builder.dart';
import 'package:protibeshi_app/views/tabs/profile/components/listings/bike.dart';
import 'package:protibeshi_app/views/tabs/profile/components/listings/book.dart';
import 'package:protibeshi_app/views/tabs/explore/explore_helper.dart';

// class ServiceListings extends ConsumerWidget {
//   const ServiceListings({required this.fromCategoryPage,Key? key}) : super(key: key);
//   final bool fromCategoryPage;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ref.watch(getBookListProvider).maybeMap(
//         orElse: () => Container(),
//         error: (_) => Container(),
//         loaded: (books) {
//           final bookLists = books.data
//               .where((element) =>
//                   element.userId != FirebaseConstants.currentUserId)
//               .toList();
//           return BookShowcase(
//             bookList: books.data.isEmpty ? [] : bookLists,
//             fromCategoryPage: fromCategoryPage,
//             myBooks: false,
//           );
//         });
//   }
// }

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  List<NameChipModel> nameChipList = [
    NameChipModel(label: 'All'),
    NameChipModel(label: 'Food'),
    NameChipModel(label: 'Drinks'),
    NameChipModel(label: 'Coffee'),
    NameChipModel(label: 'Restaurants'),
    NameChipModel(label: 'Shopping'),
    NameChipModel(label: 'Events'),
    NameChipModel(label: 'Hotels'),
    NameChipModel(label: 'Places'),
    NameChipModel(label: 'Art'),
    NameChipModel(label: 'Nature'),
    NameChipModel(label: 'Outdoors'),
    NameChipModel(label: 'Travel'),
  ];

  List<PhotoViewGridModel> rentFromNeighbourList = [
    PhotoViewGridModel(
        url:
            'https://images.unsplash.com/photo-1634900003938-aba5f17f3da7?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60',
        itemName: 'Rent from Neighbour',
        location: '69 meters away',
        amount: 30.0),
    PhotoViewGridModel(
        url:
            'https://images.unsplash.com/photo-1593642532781-03e79bf5bec2?ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=688&q=80',
        itemName: 'Rent from Neighbour',
        amount: 50.0),
    PhotoViewGridModel(
        url:
            'https://images.unsplash.com/photo-1634900003938-aba5f17f3da7?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60',
        itemName: 'Rent from Neighbour',
        location: '69 meters away',
        amount: 699.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Image.asset(MyImages.logo),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_outlined,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
         onRefresh: () async {
            await ref.read(getBikeProductProvider.notifier).allBikeList();
            await ref.read(getBookProductProvider.notifier).allBookList();
            await ref.read(getServiceProvider.notifier).allServiceList();
            await ref.read(getTeachingProvider.notifier).allServiceList();
          },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 0),
                  height: 50.0,
                  child: ListView.builder(
                      itemCount: nameChipList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: ChoiceChip(
                              onSelected: (select) {
                                setState(() {
                                  nameChipList[index].selected = select;
                                });
                              },
                              label: Text(
                                nameChipList[index].label,
                              ),
                              selected: nameChipList[index].selected),
                        );
                      })),
              const BookListings(fromCategoryPage: true,),
              const BikeListings(fromCategoryPage: true,),
              //const ServiceListings(fromCategoryPage: true,),
            ],
          ),
        ),
      ),
    );
  }
}

class BookListingsold extends ConsumerWidget {
  const BookListingsold({required this.fromCategoryPage, Key? key}) : super(key: key);
  final bool fromCategoryPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getBookProductProvider).maybeMap(
        orElse: () => Container(),
        error: (_) => Container(),
        loaded: (books) {
          final bookList =  books.data
                    .where((element) =>
                        element.userId != FirebaseConstants.firebaseInstance.currentUser!.uid)
                    .toList();
          return BooksShowcase(
            bookList: books.data.isEmpty
                ? []
                : bookList,
            fromCategoryPage: fromCategoryPage,
            myBooks: false,
          );
        });
  }
}
class BookListings extends ConsumerWidget {
  const BookListings({required this.fromCategoryPage, Key? key}) : super(key: key);
  final bool fromCategoryPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BookBuilder(builder: ((context, bookList) {
      final books =  bookList
                    .where((element) =>
                        element.userId != FirebaseConstants.firebaseInstance.currentUser!.uid)
                    .toList();
      return BooksShowcase(
            bookList: books.isEmpty
                ? []
                : books,
            fromCategoryPage: fromCategoryPage,
            myBooks: false,
          ); } 
    
    ));
  }
}

class BikeListings extends ConsumerWidget {
  const BikeListings({required this.fromCategoryPage, Key? key}) : super(key: key);
  final bool fromCategoryPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BikeBuilder(builder: ((context, bikeList) {
       final bikes =  bikeList
                    .where((element) =>
                        element.userId != FirebaseConstants.firebaseInstance.currentUser!.uid)
                    .toList();
      return BikesShowcase(
        bikeList: bikes.isEmpty
                ? []
                : bikes,
        fromCategoryPage: fromCategoryPage, 
        myBikes: !fromCategoryPage);
    } 
    
    ));
  }
}
