// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// class Starpage extends StatelessWidget {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: FutureBuilder(builder: (context, snapshot) {
//           print('Executed1');
//           return ListView.builder(
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 Random random = new Random();
//                 var imageIndex = random.nextInt(4);
//                 return Padding(
//                   padding:
//                       EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(16.0)),
//                       boxShadow: <BoxShadow>[
//                         BoxShadow(
//                           color: Colors.black87,
//                           offset: Offset(4, 4),
//                           blurRadius: 16,
//                         ),
//                       ],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                       child: AspectRatio(
//                         aspectRatio: 2.7,
//                         child: Stack(
//                           children: <Widget>[
//                             Row(
//                               children: <Widget>[
//                                 AspectRatio(
//                                   aspectRatio: 0.90,
//                                   child: Image.network(
//                                     "https://specials-images.forbesimg.com/imageserve/1206109618/960x0.jpg?fit=scale",
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     padding: EdgeInsets.all(
//                                         MediaQuery.of(context).size.width >= 360
//                                             ? 12
//                                             : 8),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Text(
//                                           "Cristiano Ronaldo",
//                                           maxLines: 1,
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             fontFamily: 'Lekton-Bold',
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15,
//                                           ),
//                                           overflow: TextOverflow.fade,
//                                         ),
//                                         Text(
//                                           "Portuguese",
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               fontFamily: 'Lekton-Bold',
//                                               color: Colors.black87
//                                                   .withOpacity(0.8)),
//                                         ),
//                                         Expanded(
//                                           child: SizedBox(),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Material(
//                               color: Colors.transparent,
//                               child: InkWell(
//                                 highlightColor: Colors.transparent,
//                                 splashColor: Colors.teal,
//                                 onTap: () {
//                                   try {
//                                     // Navigator.push(
//                                     //     context,
//                                     //     MaterialPageRoute(
//                                     //         builder: (context) => Room(
//                                     //             {
//                                     //               'hotelId': hotel.id,
//                                     //             },
//                                     //             hotel
//                                     //                 .totalRoomTypesAvailable,
//                                     //             snapshot.data.hotels,
//                                     //             roleData,
//                                     //             radioItem,
//                                     //             text,
//                                     //             startdate,
//                                     //             enddate,
//                                     //             snapshot
//                                     //                 .data
//                                     //                 .hotels[index]
//                                     //                 .rooms[index]
//                                     //                 .id)));
//                                   } catch (e) {}
//                                 },
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               });
//         }),
//       ),
//     );
//   }
// }
