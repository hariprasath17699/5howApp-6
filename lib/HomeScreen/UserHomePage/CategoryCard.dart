// import 'package:flutter/material.dart';
//
// class CategoryCard extends StatelessWidget {
//   final String svgSrc;
//   final String title;
//   final press;
//   const CategoryCard({
//     required this.svgSrc,
//     required this.title,
//     required this.press,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(13),
//         child: Container(
//           // padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(13),
//             boxShadow: [
//               BoxShadow(
//                   offset: Offset(0, 17),
//                   blurRadius: 17,
//                   spreadRadius: -23,
//                   color: Colors.black),
//             ],
//           ),
//
//           child: Material(
//             color: Colors.transparent,
//             child: InkWell(
//               onTap: press,
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: <Widget>[
//                     Spacer(),
//                     Container(
//                       padding: const EdgeInsets.only(right: 10, bottom: 35),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                         child: AspectRatio(
//                           aspectRatio: 0.9,
//                           child: Stack(
//                             children: [
//                               Row(
//                                 children: [
//                                   AspectRatio(
//                                     aspectRatio: 0.90,
//                                     child: Image.network(svgSrc,
//                                         fit: BoxFit.cover),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Spacer(),
//                         Text(
//                           title,
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context)
//                               .textTheme
//                               .title!
//                               .copyWith(fontSize: 15),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
