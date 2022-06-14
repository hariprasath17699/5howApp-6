// import 'package:flutter/material.dart';
// import 'package:star_event/HomeScreen/AdobeXdUi/StarLogin.dart';
// import 'package:star_event/HomeScreen/AdobeXdUi/UserLogin.dart';
//
// class IntroductionScreen extends StatefulWidget {
//   @override
//   _IntroductionScreenState createState() => _IntroductionScreenState();
// }
//
// class _IntroductionScreenState extends State<IntroductionScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 48, right: 48, bottom: 8, top: 600),
//               child: Container(
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(24.0)),
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                       color: Colors.blueGrey,
//                       blurRadius: 8,
//                       offset: Offset(4, 4),
//                     ),
//                   ],
//                 ),
//                 child: Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     borderRadius: BorderRadius.all(Radius.circular(24.0)),
//                     highlightColor: Colors.transparent,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => StarLoginscreen()),
//                       );
//                     },
//                     child: Center(
//                       child: Text(
//                         "Star Login",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16,
//                             color: Colors.black),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 48, right: 48, bottom: 32, top: 10),
//               child: Container(
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(24.0)),
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                       color: Colors.blueGrey,
//                       blurRadius: 8,
//                       offset: Offset(4, 4),
//                     ),
//                   ],
//                 ),
//                 child: Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     borderRadius: BorderRadius.all(Radius.circular(24.0)),
//                     highlightColor: Colors.transparent,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Loginscreen()),
//                       );
//                     },
//                     child: Center(
//                       child: Text(
//                         "User Login",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).padding.bottom,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
