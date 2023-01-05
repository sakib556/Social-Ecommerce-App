
import 'package:flutter/material.dart';
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:protibeshi_app/views/tabs/profile/components/listings/my_listings.dart';

class MyListingPage extends StatelessWidget {
  final BorrowPostModel borrowPost;
  const MyListingPage({Key? key, required this.borrowPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          body: MyListings(borrowPost: borrowPost,),
      ),
    );
  }
}
