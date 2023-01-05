// import 'package:flutter/material.dart';

// class PhotoViewGrid extends StatelessWidget {
//   final String url;
//   final String itemname;
//   final String? location;
//   final double amount;
//   final bool isLast;
//   final VoidCallback onPressedArrow;
//   const PhotoViewGrid(
//       {Key? key,
//       required this.url,
//       required this.itemname,
//       this.location,
//       required this.amount,
//       required this.isLast,
//       required this.onPressedArrow})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final colorSceme = Theme.of(context).colorScheme;
//     return Container(
//       padding: const EdgeInsets.all(9),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               SizedBox(
//                 height: 150,
//                 width: 200.0,
//                 child: Image.network(
//                   url,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               isLast
//                   ? GestureDetector(
//                       onTap: onPressedArrow,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 16.0, right: 8.0),
//                         child: CircleAvatar(
//                           foregroundColor: colorSceme.onPrimary,
//                           backgroundColor: colorSceme.primary,
//                           child: const Icon(Icons.arrow_forward_ios_rounded),
//                         ),
//                       ),
//                     )
//                   : const SizedBox(),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//             child: Text(
//               itemname,
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//           ),
//           location == null
//               ? const SizedBox()
//               : Text(
//                   location!,
//                   style: Theme.of(context).textTheme.caption,
//                 ),
//           Row(
//             children: [
//               Text(
//                 '$amount',
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyText2!
//                     .copyWith(color: colorSceme.primary),
//               ),
//               Text(
//                 '/day',
//                 style: Theme.of(context).textTheme.caption,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


