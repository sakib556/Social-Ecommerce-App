// import 'package:flutter/material.dart';
// import 'package:protibeshi_app/views/tabs/explore/components/photoview_grid.dart';


// class ExplorerShowcase extends StatelessWidget {
//   final String headline;
//   final List manualList;
//   final Widget seeAllPage;

//   const ExplorerShowcase(
//       {Key? key,
//       required this.headline,
//       required this.manualList,
//       required this.seeAllPage})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     void _onPressedSeeAll() {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => seeAllPage));
//     }

//     return SizedBox(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     headline,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline6!
//                         .copyWith(fontWeight: FontWeight.w500),
//                     textAlign: TextAlign.start,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: _onPressedSeeAll,
//                   child: Text(
//                     'See All',
//                     style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                         fontWeight: FontWeight.w500,
//                         color: Theme.of(context).colorScheme.primary),
//                     textAlign: TextAlign.end,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: SizedBox(
//                       height: 250.0,
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           ...manualList.map((e) {
//                             return PhotoViewGrid(
//                               onPressedArrow: _onPressedSeeAll,
//                               itemname: e.itemName,
//                               url: e.url,
//                               location: e.location,
//                               amount: e.amount,
//                               isLast: manualList.indexOf(e) ==
//                                   manualList.length - 1,
//                             );
//                           }).toList(),
//                         ],
//                       )),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
