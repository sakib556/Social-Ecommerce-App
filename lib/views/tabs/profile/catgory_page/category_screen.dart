import 'package:flutter/material.dart';
import 'package:protibeshi_app/themes/images.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/components/category_name.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/subcategory/subcategory_view.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/category_helper.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Image.asset(MyImages.logo),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...categories.map((category) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CategoryName(name: category.name),
                  SizedBox(
                      height: 150.0,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 2.0),
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...category.subCategories.map((subCategory) {
                            return SubCategoryView(
                                categoryName: category.name,
                                categoryIndex: categories.indexOf(category),
                                subCategoryIndex:
                                    category.subCategories.indexOf(subCategory),
                                subCategory: subCategory);
                          })
                        ],
                      )),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
