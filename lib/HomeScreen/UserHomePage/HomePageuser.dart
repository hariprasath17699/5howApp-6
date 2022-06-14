// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import 'package:star_event/HomeScreen/UserHomePage/CategoryCard.dart';
//
// import 'SearchBar.dart';
//
// class UserHomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context)
//         .size; //this gonna give us total height and with of our device
//     return Scaffold(
//       body: ResponsiveBuilder(builder: (context, sizingInformation) {
//         if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
//           return SafeArea(
//             child: Stack(
//               children: <Widget>[
//                 Container(
//                   // Here the height of the container is 45% of our total height
//                   height: size.height * .45,
//                   decoration: BoxDecoration(
//                     color: Color(0xFFF5CEB8),
//                     image: DecorationImage(
//                       alignment: Alignment.centerLeft,
//                       image:
//                           AssetImage("assets/images/undraw_pilates_gpdb.png"),
//                     ),
//                   ),
//                 ),
//                 SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Column(
//                           children: [
//                             Align(
//                               alignment: Alignment.topLeft,
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 height: 52,
//                                 width: 52,
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFF2BEA1),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child:
//                                     SvgPicture.asset("assets/icons/menu.svg"),
//                               ),
//                             ),
//                             // Padding(
//                             //   padding: const EdgeInsets.only(
//                             //       bottom: 0, left: 0, right: 150, top: 5),
//                             //   child: Text(
//                             //     "Hello, Hari",
//                             //     style: TextStyle(fontSize: 20),
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                         SearchBar(),
//                         Expanded(
//                           child: GridView.count(
//                             crossAxisCount: 2,
//                             childAspectRatio: .85,
//                             crossAxisSpacing: 20,
//                             mainAxisSpacing: 20,
//                             children: <Widget>[
//                               CategoryCard(
//                                 title: "Diet Recommendation",
//                                 svgSrc: "assets/icons/Hamburger.svg",
//                                 press: () {},
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         } else {}
//         throw "error";
//       }),
//     );
//   }
// }
