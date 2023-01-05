import 'package:flutter/material.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/subcategory/components/product_forms/book_form.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/subcategory/components/product_forms/bike_form.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/subcategory/components/service_form.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/subcategory/components/teaching_form.dart';

class ProductScreen extends StatelessWidget {
  final int index;
  final String categoryName;
  final String subCategoryName;
  const ProductScreen({
    Key? key,
    required this.index,
    required this.categoryName,
    required this.subCategoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> productWidgetList = [
      BikeForm(
        categoryName: categoryName,
        subCategoryName: subCategoryName,
      ),
      BookForm(
        categoryName: categoryName,
        subCategoryName: subCategoryName,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        iconTheme: const IconThemeData(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: productWidgetList[index],
        ),
      ),
    );
  }
}

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: ServiceForm(),
          ),
        ),
      ),
    );
  }
}
class TeachingScreen extends StatelessWidget {
  const TeachingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: TeachingForm(),
          ),
        ),
      ),
    );
  }
}


