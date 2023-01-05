import 'package:flutter/material.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/category_helper.dart';
import 'package:protibeshi_app/views/tabs/profile/catgory_page/subcategory/components/subcategory_screen.dart';

class SubCategoryView extends StatelessWidget {
  final int categoryIndex;
  final String categoryName;
  final int subCategoryIndex;
  final SubCategoryViewModel subCategory;
  const SubCategoryView(
      {Key? key,
      required this.categoryIndex,
      required this.categoryName,
      required this.subCategory,
      required this.subCategoryIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> formsList = [
      ProductScreen(
        index: subCategoryIndex,
        categoryName: categoryName,
        subCategoryName: subCategory.name,
      ),
      const ServiceScreen(),
      const TeachingScreen() 
    ];
    return Padding(
      padding: const EdgeInsets.all(9),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return formsList[categoryIndex];
          }));
        },
        child: Column(
          children: [
            SizedBox(
              height: 80,
              width: 110.0,
              child: Image.network(
                subCategory.imgUrl,
                fit: BoxFit.contain,
              ),
            ),
            const SpaceVertical(5),
            Text(subCategory.name)
          ],
        ),
      ),
    );
  }
}
