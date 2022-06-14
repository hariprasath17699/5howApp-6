// import 'dart:async';
// import 'dart:convert';
//
// import 'package:adobe_xd/pinned.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:http/http.dart' as http;
// import 'package:localstorage/localstorage.dart';
// import 'package:star_event/HomeScreen/AdobeXdUi/StarDetailsScreen.dart';
// import 'package:star_event/HomeScreen/Json/Starmodel.dart';
// import 'package:star_event/HomeScreen/UserHomePage/SearchBar.dart';
//
// class UserHomeJson extends StatefulWidget {
//   UserHomeJson();
//   @override
//   _UserHomeJsonState createState() => _UserHomeJsonState();
// }
//
// class _UserHomeJsonState extends State<UserHomeJson> {
//   _UserHomeJsonState();
//   late List result;
//   late List selectedSeater, selectedType;
//   bool loading = true;
//   late ScrollController controller;
//   var sliderImageHieght = 0.0;
//   late Future<StarModel> star;
//
//   Future<List> getData() async {
//     final LocalStorage storage = new LocalStorage('Star');
//     var client = http.Client();
//     // final url = "http://192.168.29.103/StarLoginAndRegister/getStars.php";
//     var url = Uri.parse(
//         "https://starappeprodix.000webhostapp.com/starapp/getStars.php");
//     print(storage.getItem("Interest"));
//     var response = await client.post(url, headers: {
//       "Accept": "application/json",
//       "Access-Control_Allow_Origin": "*"
//     }, body: {
//       "interest": "Football",
//     });
//     print(storage.getItem('interest'));
//     print(response.body);
//     print(response.statusCode);
//     var dataRecieved = json.decode(response.body.toString());
//     print(response);
//     print("dataRecieved:${dataRecieved}");
//
//     return dataRecieved;
//   }
//
//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: new FutureBuilder<List>(
//           future: getData(),
//           builder: (context, snapshot) {
//             print(snapshot.hasData);
//             return snapshot.hasData
//                 ? new UserHomeScreen(
//                     list: snapshot.data!,
//                   )
//                 : new Center(
//                     child: CircularProgressIndicator(),
//                   );
//           }),
//     );
//   }
// }
//
// class UserHomeScreen extends StatefulWidget {
//   final List<dynamic> list;
//
//   UserHomeScreen({required this.list});
//
//   @override
//   _UserHomeScreenState createState() => _UserHomeScreenState(list);
// }
//
// class _UserHomeScreenState extends State<UserHomeScreen> {
//   List list;
//   _UserHomeScreenState(this.list);
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Stack(
//       children: <Widget>[
//         SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SearchBar(),
//                 Expanded(
//                   child: GridView.builder(
//                       shrinkWrap: false,
//                       scrollDirection: Axis.vertical,
//                       gridDelegate:
//                           new SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         childAspectRatio: MediaQuery.of(context).size.width /
//                             (MediaQuery.of(context).size.height / 1.5),
//                       ),
//                       itemCount: list == null ? 0 : list.length,
//                       itemBuilder: (context, index) {
//                         return Stack(
//                           children: <Widget>[
//                             Pinned.fromPins(
//                               Pin(size: 167.5, start: 23.7),
//                               Pin(size: 225.5, middle: 0.3533),
//                               child: Stack(
//                                 children: <Widget>[
//                                   Pinned.fromPins(
//                                     Pin(start: 0.0, end: 0.0),
//                                     Pin(start: 0.0, end: 0.0),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(12.0),
//                                         color: Colors.grey[350],
//                                       ),
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(start: 0.0, end: 0.0),
//                                     Pin(size: 98.9, start: 0.0),
//                                     child: Stack(
//                                       children: <Widget>[
//                                         Pinned.fromPins(
//                                           Pin(start: 1.5, end: 0.0),
//                                           Pin(start: 0.0, end: 10.0),
//                                           child: Stack(
//                                             children: <Widget>[
//                                               Pinned.fromPins(
//                                                 Pin(start: -1.7, end: 0.5),
//                                                 Pin(start: -3.5, end: -3.7),
//                                                 child:
//                                                     // Adobe XD layer: 'jo' (shape)
//                                                     Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           top: 4.5, left: 0.5),
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.only(
//                                                         topLeft:
//                                                             Radius.circular(
//                                                                 12.5),
//                                                         topRight:
//                                                             Radius.circular(
//                                                                 12.5),
//                                                         bottomLeft: Radius.zero,
//                                                         bottomRight:
//                                                             Radius.zero,
//                                                       ),
//                                                       image: DecorationImage(
//                                                         image: NetworkImage(
//                                                           list[index]['image'],
//                                                         ),
//                                                         fit: BoxFit.fitWidth,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Pinned.fromPins(
//                                                 Pin(start: 0.0, end: 0.0),
//                                                 Pin(start: 0.0, end: 0.0),
//                                                 child: SvgPicture.string(
//                                                   _svg_xkil9e,
//                                                   allowDrawingOutsideViewBox:
//                                                       true,
//                                                   fit: BoxFit.fill,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 70.0, start: 8.2),
//                                     Pin(size: 16.0, middle: 0.5051),
//                                     child: Text(
//                                       list[index]['username'],
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Poppins-SemiBold',
//                                         fontSize: 8,
//                                         color: const Color(0xff000000),
//                                         height: 1,
//                                       ),
//                                       textHeightBehavior: TextHeightBehavior(
//                                           applyHeightToFirstAscent: false),
//                                       textAlign: TextAlign.left,
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 106.0, start: 8.6),
//                                     Pin(size: 12.0, middle: 0.5883),
//                                     child: Text(
//                                       'Lorem Ipsum Lorem Ipsum',
//                                       style: TextStyle(
//                                         fontFamily: 'Poppins-Regular',
//                                         fontSize: 9,
//                                         color: const Color(0xff444444),
//                                         height: 1.4444444444444444,
//                                       ),
//                                       textHeightBehavior: TextHeightBehavior(
//                                           applyHeightToFirstAscent: false),
//                                       textAlign: TextAlign.left,
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 82.0, start: 8.6),
//                                     Pin(size: 12.0, end: 31.8),
//                                     child: Text(
//                                       'Hollywood Vampires',
//                                       style: TextStyle(
//                                         fontFamily: 'Poppins-Regular',
//                                         fontSize: 9,
//                                         color: const Color(0xff444444),
//                                         height: 1.4444444444444444,
//                                       ),
//                                       textHeightBehavior: TextHeightBehavior(
//                                           applyHeightToFirstAscent: false),
//                                       textAlign: TextAlign.left,
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 41.0, start: 8.3),
//                                     Pin(size: 11.0, middle: 0.7818),
//                                     child: Text(
//                                       'Next Events',
//                                       style: TextStyle(
//                                         fontFamily: 'Poppins-Medium',
//                                         fontSize: 8,
//                                         color: const Color(0xff000000),
//                                         height: 1.625,
//                                       ),
//                                       textHeightBehavior: TextHeightBehavior(
//                                           applyHeightToFirstAscent: false),
//                                       textAlign: TextAlign.left,
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 86.3, start: 8.0),
//                                     Pin(size: 12.6, end: 11.7),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(21.5),
//                                         color: const Color(0xff3db761),
//                                       ),
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 64.0, start: 15.6),
//                                     Pin(size: 8.0, end: 14.3),
//                                     child: Text(
//                                       '5Aug 2021 -  Seat 10/50',
//                                       style: TextStyle(
//                                         fontFamily: 'Poppins',
//                                         fontSize: 6,
//                                         color: const Color(0xffffffff),
//                                         height: 2.1666666666666665,
//                                       ),
//                                       textHeightBehavior: TextHeightBehavior(
//                                           applyHeightToFirstAscent: false),
//                                       textAlign: TextAlign.left,
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 46.2, start: 7.8),
//                                     Pin(size: 12.6, middle: 0.6883),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(21.5),
//                                         color: const Color(0xffffffff),
//                                         border: Border.all(
//                                             width: 0.5,
//                                             color: const Color(0xffe6e6e6)),
//                                       ),
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 46.2, middle: 0.4812),
//                                     Pin(size: 12.6, middle: 0.6883),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(21.5),
//                                         color: const Color(0xffffffff),
//                                         border: Border.all(
//                                             width: 0.5,
//                                             color: const Color(0xffe6e6e6)),
//                                       ),
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 46.2, end: 12.9),
//                                     Pin(size: 12.6, middle: 0.6883),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(21.5),
//                                         color: const Color(0xffffffff),
//                                         border: Border.all(
//                                             width: 0.5,
//                                             color: const Color(0xffe6e6e6)),
//                                       ),
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 16.0, start: 21.3),
//                                     Pin(size: 8.0, middle: 0.6828),
//                                     child: Text(
//                                       list[index]['interest'],
//                                       style: TextStyle(
//                                         fontFamily: 'Poppins-Regular',
//                                         fontSize: 4,
//                                         color: const Color(0xff000000),
//                                         height: 2.1666666666666665,
//                                       ),
//                                       textHeightBehavior: TextHeightBehavior(
//                                           applyHeightToFirstAscent: false),
//                                       textAlign: TextAlign.left,
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 11.0, middle: 0.4764),
//                                     Pin(size: 8.0, middle: 0.6828),
//                                     child: Text(
//                                       'pop',
//                                       style: TextStyle(
//                                         fontFamily: 'Poppins-Regular',
//                                         fontSize: 6,
//                                         color: const Color(0xff000000),
//                                         height: 2.1666666666666665,
//                                       ),
//                                       textHeightBehavior: TextHeightBehavior(
//                                           applyHeightToFirstAscent: false),
//                                       textAlign: TextAlign.left,
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 14.0, middle: 0.7886),
//                                     Pin(size: 8.0, middle: 0.6828),
//                                     child: Text(
//                                       'Actor',
//                                       style: TextStyle(
//                                         fontFamily: 'Poppins-Regular',
//                                         fontSize: 6,
//                                         color: const Color(0xff000000),
//                                         height: 2.1666666666666665,
//                                       ),
//                                       textHeightBehavior: TextHeightBehavior(
//                                           applyHeightToFirstAscent: false),
//                                       textAlign: TextAlign.left,
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 106.5, start: 8.0),
//                                     Pin(size: 14.6, end: 10.7),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(21.5),
//                                         color: const Color(0xff00b141),
//                                       ),
//                                     ),
//                                   ),
//                                   Pinned.fromPins(
//                                     Pin(size: 86.0, start: 15.6),
//                                     Pin(size: 11.0, end: 13.3),
//                                     child: Text(
//                                       '5Aug 2021 -  Seat 10/50',
//                                       style: TextStyle(
//                                         fontFamily: 'Poppins',
//                                         fontSize: 8,
//                                         color: const Color(0xffffffff),
//                                         height: 1.625,
//                                       ),
//                                       textHeightBehavior: TextHeightBehavior(
//                                           applyHeightToFirstAscent: false),
//                                       textAlign: TextAlign.left,
//                                     ),
//                                   ),
//                                   Material(
//                                     color: Colors.transparent,
//                                     child: InkWell(
//                                       highlightColor: Colors.transparent,
//                                       splashColor: Colors.grey,
//                                       onTap: () {
//                                         try {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       StarsDetailsPage(
//                                                           Name: list[index]
//                                                               ['username'],
//                                                           Interest: list[index]
//                                                               ['interest'],
//                                                           Image: list[index]
//                                                               ['image'],
//                                                           DOB: list[index]
//                                                               ['dob'])));
//                                         } catch (e) {}
//                                       },
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                         throw 'error';
//                       }),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     ); //this gonna give us total height and with of our device
//   }
// }
//
// //
// // class ItemList extends StatefulWidget {
// //   final List list;
// //
// //   const ItemList({required this.list});
// //   @override
// //   Future<Widget> build(BuildContext context) async {
// //     if (list.isNotEmpty) {
// //       return GridView.builder(
// //           shrinkWrap: false,
// //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //               crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
// //           itemCount: list == null ? 0 : list.length,
// //           itemBuilder: (context, index) {
// //             return Card(
// //               child: Stack(
// //                 children: [
// //                   Column(
// //                     children: [
// //                       // AspectRatio(
// //                       //   aspectRatio: 2.10,
// //                       //   child: Image.network(
// //                       //     list[index]['image'].toString(),
// //                       //     fit: BoxFit.fill,
// //                       //   ),
// //                       // ),
// //                       Padding(
// //                         padding: const EdgeInsets.only(right: 110),
// //                         child: Center(
// //                           child: Text(
// //                             list[index]['username'],
// //                             style: TextStyle(color: Colors.black, fontSize: 15),
// //                           ),
// //                         ),
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.only(right: 90),
// //                         child: Center(
// //                           child: Text(
// //                             list[index]['country'],
// //                             style: TextStyle(color: Colors.black, fontSize: 15),
// //                           ),
// //                         ),
// //                       ),
// //                       Padding(
// //                           padding: const EdgeInsets.all(8.0),
// //                           child: SizedBox(
// //                               // child: Image.network(
// //                               //   list[index]['Image'].toString(),
// //                               //   width: 100.0,
// //                               //   height: 100.0,
// //                               // ), // child: Image.network(
// //                               //   document.data()["image_logo"],
// //                               //   width: 100.0,
// //                               //   height: 100.0,
// //                               // ),
// //                               )),
// //                       Text(
// //                         list[index]['interest'],
// //                         style: TextStyle(color: Colors.black),
// //                       ),
// //                     ],
// //                   ),
// //                   Material(
// //                     color: Colors.transparent,
// //                     child: InkWell(
// //                       highlightColor: Colors.transparent,
// //                       splashColor: Colors.red,
// //                       onTap: () {
// //                         try {
// //                           Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                   builder: (context) => StarDetails(
// //                                       Name: list[index]['username'],
// //                                       Interest: list[index]['interest'],
// //                                       Image: list[index]['image'],
// //                                       DOB: list[index]['dob'])));
// //                         } catch (e) {}
// //                       },
// //                     ),
// //                   )
// //                 ],
// //               ),
// //             );
// //           });
// //     } else {
// //       Center(
// //         child: CircularProgressIndicator(),
// //       );
// //     }
// //   }
// //
// //   @override
// //   State<StatefulWidget> createState() {
// //     // TODO: implement createState
// //     throw UnimplementedError();
// //   }
// // }
// const String _svg_xkil9e =
//     '<svg viewBox="0.0 0.0 167.5 98.9" ><path transform="translate(-10992.93, -1098.49)" d="M 10992.931640625 1197.345947265625 L 10992.931640625 1110.823974609375 C 10992.931640625 1104.041015625 10998.4814453125 1098.490966796875 11005.2646484375 1098.490966796875 L 11148.0556640625 1098.490966796875 C 11154.837890625 1098.490966796875 11160.3876953125 1104.041015625 11160.3876953125 1110.823974609375 L 11160.3876953125 1197.345947265625" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
