// import 'package:flutter/material.dart';
// import 'package:protibeshi_app/models/category/all_categories.dart';
// import 'package:protibeshi_app/models/category/child_category_model.dart';
// import 'package:protibeshi_app/models/category/parent_category.model.dart';
// import 'package:protibeshi_app/models/category/second_parent_category_model.dart';

// class CreateBorrowPostProductType extends StatefulWidget {
//   final Function(
//           ParentCategoryModelOld, SecondParentCategoryModel, ChildCategoryModel)
//       onPressedNext;

//   const CreateBorrowPostProductType({
//     Key? key,
//     required this.onPressedNext,
//   }) : super(key: key);

//   @override
//   _CreateBorrowPostProductTypeState createState() =>
//       _CreateBorrowPostProductTypeState();
// }

// class _CreateBorrowPostProductTypeState
//     extends State<CreateBorrowPostProductType> {
//   int _expandedIndex = -1;

//   bool _isSearching = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _isSearching
//             ? const TextField(
//                 autofocus: true,
//                 decoration: InputDecoration(
//                   hintText: 'Search',
//                 ))
//             : const Text(
//                 "Product Type",
//               ),
//         leading: BackButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           color: Theme.of(context).colorScheme.onSurface,
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 _isSearching = !_isSearching;
//               });
//             },
//             icon: const Icon(
//               Icons.search,
//             ),
//           ),
//         ],
//       ),
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).requestFocus(FocusNode());
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: _buildExpansionList(),
//             )),
//           ],
//         ),
//       ),
//     );
//   }

//   ExpansionPanelList _buildExpansionList() {
//     return ExpansionPanelList(
//       // dividerColor: Colors.transparent,
//       expansionCallback: (int index, bool isExpanded) {
//         setState(() {
//           if (_expandedIndex == index) {
//             _expandedIndex = -1;
//           } else {
//             _expandedIndex = index;
//           }
//         });
//       },
//       elevation: 0,
//       children:
//           parentCategories.map<ExpansionPanel>((ParentCategoryModelOld item) {
//         return _buildExpansionPanel(item);
//       }).toList(),
//     );
//   }

//   ExpansionPanel _buildExpansionPanel(ParentCategoryModelOld item) {
//     return ExpansionPanel(
//       canTapOnHeader: true,
//       headerBuilder: (BuildContext context, bool isExpanded) {
//         return ListTile(title: Text(item.name));
//       },
//       body: Padding(
//         padding: const EdgeInsets.only(
//           right: 16,
//           left: 16,
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border(
//               left: BorderSide(
//                 color: Theme.of(context).colorScheme.onSurface.withOpacity(0.30),
//               ),
//             ),
//             // color: Colors.transparent,
//           ),
//           child: Column(
//             children: secondParentCategories
//                 .where((element) => element.parentCategoryId == item.id)
//                 .toList()
//                 .map(
//                   (e) => _buildSecondExpansionPanel(e),
//                 )
//                 .toList(),
//           ),
//         ),
//       ),
//       isExpanded:
//           _expandedIndex == parentCategories.indexOf(item) ? true : false,
//     );
//   }

//   Widget _buildSecondExpansionPanel(
//       SecondParentCategoryModel secondParentCategory) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         dividerColor:Theme.of(context).colorScheme.onSurface.withOpacity(.4)),
//       // data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//       child: ExpansionTile(
//         childrenPadding: const EdgeInsets.only(
//           right: 16,
//           left: 16,
//         ),
//         title: Text(secondParentCategory.name),
//         children: childCategories
//             .where((child) =>
//                 child.secondParentCategoryId == secondParentCategory.id)
//             .toList()
//             .map((e) => Container(
//                   decoration: BoxDecoration(
//                     border: Border(
//                       left: BorderSide(
//                         color: Theme.of(context).colorScheme.onSurface.withOpacity(0.30),
//                       ),
//                     ),
//                     // color: MyColors.whiteColor,
//                   ),
//                   child: ListTile(
//                     onTap: () {
//                       widget.onPressedNext(
//                         parentCategories.firstWhere(
//                             (element) => element.id == e.parentCategoryId),
//                         secondParentCategories.firstWhere((element) =>
//                             element.id == e.secondParentCategoryId),
//                         e,
//                       );
//                     },
//                     title: Text(
//                       e.name,
//                       style: Theme.of(context).textTheme.subtitle2,
//                     ),
//                   ),
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }
