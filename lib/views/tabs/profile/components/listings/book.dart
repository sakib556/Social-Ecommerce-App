import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:protibeshi_app/models/listing/sub_category/book_model.dart';
import 'package:protibeshi_app/models/notification/notification.dart';
import 'package:protibeshi_app/models/offer/offer.dart';
import 'package:protibeshi_app/models/offer/rent_update_information.dart';
import 'package:protibeshi_app/providers/notification_provider.dart';
import 'package:protibeshi_app/providers/offer_provider.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/tabs/explore/offer/book_offer_screen.dart';
import 'package:protibeshi_app/views/custom_widgets/item_card.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/category_screen.dart';

class BooksShowcase extends StatelessWidget {
  final List<BookModel> bookList;
  final bool fromCategoryPage;
  final BorrowPostModel? borrowPost;
  final bool myBooks;

  const BooksShowcase(
      {Key? key,
      required this.bookList,
      required this.fromCategoryPage,
      this.borrowPost,
      required this.myBooks})
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
                  "Books",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
              ),
              myBooks
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
        BookList(
          bookList: bookList,
          fromCategoryPage: fromCategoryPage,
          borrowPost: borrowPost,
        )
      ],
    );
  }
}

class BookList extends StatelessWidget {
  final List<BookModel> bookList;
  final bool fromCategoryPage;
  final BorrowPostModel? borrowPost;

  const BookList(
      {Key? key,
      required this.bookList,
      required this.fromCategoryPage,
      this.borrowPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bookList.isNotEmpty
        ? SizedBox(
            height: 220.0,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                ...bookList.map((book) {
                  return BookView(
                    borrowPost: borrowPost,
                    book: book,
                    fromCategoryPage: fromCategoryPage,
                  );
                }).toList(),
              ],
            ))
        : const Center(child: Text("No books in listing"));
  }
}

class BookView extends StatelessWidget {
  final BookModel book;
  final bool fromCategoryPage;
  final BorrowPostModel? borrowPost;
  const BookView(
      {Key? key,
      required this.book,
      required this.fromCategoryPage,
      this.borrowPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final colorSceme = Theme.of(context).colorScheme;
    return ItemCard(
        imageUrl: book.imageUrl.isNotEmpty ? book.imageUrl.first : "",
        title: book.title,
        details: book.details,
        onTapped: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetails(
                      book: book,
                      fromCategoryPage: fromCategoryPage,
                      borrowPost: borrowPost,
                    )),
          );
        });
  }
}

class BookDetails extends ConsumerWidget {
  final BookModel book;
  final bool fromCategoryPage;
  final BorrowPostModel? borrowPost;
  const BookDetails({
    Key? key,
    this.borrowPost,
    required this.book,
    required this.fromCategoryPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Text(book.title),
            const SpaceVertical(10),
            Text(book.details),
            const SpaceVertical(10),
            Text(book.creationTime.day.toString()),
            const SpaceVertical(10),
            Text(book.locationName),
            const SpaceVertical(10),
            fromCategoryPage
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookRentOfferScreen(bookModel: book)),
                      );
                    },
                    child: const Text("Book for rent"))
                : borrowPost != null
                    ? ElevatedButton(
                        onPressed: () async {
                          String _offerId =
                              "${FirebaseConstants.firebaseInstance.currentUser!.uid}${DateTime.now().millisecondsSinceEpoch}";
                          RentUpdateInformation _updateInformation =
                              RentUpdateInformation(
                                  costFirstDay: book.costFirstDay,
                                  costPerExtraDay: book.costPerExtraDay,
                                  startDate: borrowPost!.startDate,
                                  endDate: borrowPost!.endDate,
                                  durationInDays: borrowPost!.durationInDays,
                                  lastUpdateTime: DateTime.now(),
                                  updateInformations: [],
                                  userMessages: []);
                          OfferModel _offerModel = OfferModel(
                              id: _offerId,
                              buyerId: borrowPost!.userId,
                              sellerId: FirebaseConstants.firebaseInstance.currentUser!.uid,
                              listingId: book.id,
                              rentUpdateInformation: _updateInformation,
                              pickupLocationCode: book.locationCode,
                              pickupLocationName: book.locationName,
                              pickupTime: borrowPost!.pickupTime,
                              postId: borrowPost!.id,
                              offerSentTime: DateTime.now(),
                              isPostOffer: !fromCategoryPage);
                          await ref
                              .read(offerProvider.notifier)
                              .addNewOffer(_offerModel);
                          String _notifyId =
                              "${FirebaseConstants.firebaseInstance.currentUser!.uid}${DateTime.now().millisecondsSinceEpoch}";
                          NotificationModel notifyModel = NotificationModel(
                              id: _notifyId,
                              offferId: _offerId,
                              receiverId: borrowPost!.userId,
                              isRead: false,
                              sentTime: DateTime.now());
                          await ref
                              .read(notificationProvider.notifier)
                              .addNotification(notifyModel);
                          EasyLoading.showSuccess("sent!!");
                          Navigator.pop(context);
                        },
                        child: const Text("Sent offer"))
                    : const SizedBox()
          ]),
        ),
      ),
    );
  }
}
