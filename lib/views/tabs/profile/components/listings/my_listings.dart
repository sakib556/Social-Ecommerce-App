import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/category_screen.dart';
import 'package:protibeshi_app/views/tabs/profile/components/listings/bike.dart';
import 'package:protibeshi_app/views/tabs/profile/components/listings/book.dart';
import 'package:protibeshi_app/providers/catgory_provider.dart';
import 'package:protibeshi_app/views/tabs/profile/components/listings/service.dart';
import 'package:protibeshi_app/views/tabs/profile/components/listings/teaching.dart';

class MyListings extends StatelessWidget {
  const MyListings({Key? key, this.borrowPost, this.uid}) : super(key: key);
  final BorrowPostModel? borrowPost;
  final String? uid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // height: 220.0,
        child: ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        MyBooksSection(fromCategoryPage:uid==null? false:true, borrowPost: borrowPost,uid: uid,),
        MyBikesSection(fromCategoryPage: uid==null? false:true, borrowPost: borrowPost,uid: uid),
        MyServiceSection(fromCategoryPage: uid==null? false:true, borrowPost: borrowPost),
        MyTeachingSection(fromCategoryPage: uid==null? false:true, borrowPost: borrowPost),
        const SpaceVertical(10),
      ],
    ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ListView(
  //     children: [
  //       MyBooksSection(fromCategoryPage: false, borrowPost: borrowPost),
  //       MyServiceSection(fromCategoryPage: false, borrowPost: borrowPost),
  //       MyTeachingSection(fromCategoryPage: false, borrowPost: borrowPost),
  //     ],
  //   );
  // }
}

class MyBooksSection extends ConsumerWidget {
  final BorrowPostModel? borrowPost;
  final bool fromCategoryPage;
  final String? uid;
  const MyBooksSection(
      {required this.fromCategoryPage, Key? key, this.borrowPost, this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = uid ?? FirebaseConstants.firebaseInstance.currentUser!.uid;
    return ref.watch(getBookProductProvider).maybeMap(
        orElse: () => Container(),
        error: (_) => Container(),
        loaded: (books) => books.data.isNotEmpty
            ? BooksShowcase(
                borrowPost: borrowPost,
                // headline: "My books",
                bookList: books.data
                    .where((books) => books.userId == userId)
                    .toList(),
                fromCategoryPage: fromCategoryPage,
                myBooks: !fromCategoryPage,
              )
            : !fromCategoryPage 
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add a book listing now.",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CategoryScreen()),
                            );
                          },
                          style: ButtonStyle(
                            alignment:
                                Alignment.center, // <-- had to set alignment
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.zero, // <-- had to set padding to zero
                            ),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  )
                : const SizedBox());
  }
}

class MyBikesSection extends ConsumerWidget {
  final BorrowPostModel? borrowPost;
  final bool fromCategoryPage;
  final String? uid;
  const MyBikesSection(
      {required this.fromCategoryPage, Key? key, this.borrowPost, this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = uid ?? FirebaseConstants.firebaseInstance.currentUser!.uid;
    return ref.watch(getBikeProductProvider).maybeMap(
        orElse: () => Container(),
        error: (_) => Container(),
        loaded: (bikes) => bikes.data.isNotEmpty
            ? BikesShowcase(
                borrowPost: borrowPost,
                // headline: "My books",
                bikeList: bikes.data
                    .where((books) => books.userId == userId)
                    .toList(),
                fromCategoryPage: fromCategoryPage,
                myBikes: !fromCategoryPage,
              )
            : !fromCategoryPage 
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add a bike listing now",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CategoryScreen()),
                            );
                          },
                          style: ButtonStyle(
                            alignment: Alignment
                                .centerLeft, // <-- had to set alignment
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.zero, // <-- had to set padding to zero
                            ),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  )
                : const SizedBox());
  }
}

class MyServiceSection extends ConsumerWidget {
  final BorrowPostModel? borrowPost;
  final bool fromCategoryPage;
  const MyServiceSection(
      {required this.fromCategoryPage, Key? key, this.borrowPost})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getServiceProvider).maybeMap(
        orElse: () => Container(),
        error: (_) => Container(),
        loaded: (services) => services.data.isNotEmpty
            ? ServiceShowcase(
                borrowPost: borrowPost,
                // headline: "My books",
                serviceList: services.data
                    .where((service) =>
                        service.userId == FirebaseConstants.firebaseInstance.currentUser!.uid)
                    .toList(),
                fromCategoryPage: fromCategoryPage,
                myServices: !fromCategoryPage,
              )
            :!fromCategoryPage ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add a service listing now",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CategoryScreen()),
                        );
                      },
                      style: ButtonStyle(
                        alignment: Alignment.center, // <-- had to set alignment
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero, // <-- had to set padding to zero
                        ),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ):const SizedBox());
  }
}

class MyTeachingSection extends ConsumerWidget {
  final BorrowPostModel? borrowPost;
  final bool fromCategoryPage;
  const MyTeachingSection(
      {required this.fromCategoryPage, Key? key, this.borrowPost})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTeachingProvider).maybeMap(
        orElse: () => Container(),
        error: (_) => Container(),
        loaded: (services) => services.data.isNotEmpty
            ? TeachingShowcase(
                borrowPost: borrowPost,
                serviceList: services.data
                    .where((service) =>
                        service.userId == FirebaseConstants.firebaseInstance.currentUser!.uid)
                    .toList(),
                fromCategoryPage: fromCategoryPage,
                myServices: !fromCategoryPage,
              )
            : !fromCategoryPage ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add a teaching listing now",
                        style: Theme.of(context).textTheme.subtitle2),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CategoryScreen()),
                        );
                      },
                      style: ButtonStyle(
                        alignment: Alignment.center, // <-- had to set alignment
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero, // <-- had to set padding to zero
                        ),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ):const SizedBox());
  }
}
