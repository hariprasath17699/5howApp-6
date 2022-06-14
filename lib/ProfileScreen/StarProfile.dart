// import 'package:flutter/material.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:star_event/InitialScreen/InitialScreen.dart';
//
// class StarProfile extends StatefulWidget {
//   @override
//   _StarProfileState createState() => _StarProfileState();
// }
//
// class _StarProfileState extends State<StarProfile>
//     with SingleTickerProviderStateMixin {
//   late double _scale;
//   late AnimationController _controller;
//   final LocalStorage storage = new LocalStorage('Star');
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(
//         milliseconds: 500,
//       ),
//       lowerBound: 0.0,
//       upperBound: 0.1,
//     )..addListener(() {
//         setState(() {});
//       });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
//   void logoutUser() async {
//     storage.clear();
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => IntroductionScreen()));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _scale = 1 - _controller.value;
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Center(
//             child: IconButton(
//               onPressed: () {
//                 logoutUser();
//               },
//               icon: Icon(
//                 Icons.logout,
//                 color: Colors.red,
//                 size: 30,
//               ),
//               iconSize: 30,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _animatedButton() {
//     return Container(
//       height: 50,
//       width: 250,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100.0),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0x80000000),
//               blurRadius: 12.0,
//               offset: Offset(0.0, 5.0),
//             ),
//           ],
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xff33ccff),
//               Color(0xffff99cc),
//             ],
//           )),
//       child: Center(
//         child: Text(
//           'Need a star account?',
//           style: TextStyle(
//               fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       ),
//     );
//   }
//
//   void _tapDown(TapDownDetails details) {
//     _controller.forward();
//   }
//
//   void _tapUp(TapUpDetails details) {
//     _controller.reverse();
//   }
// }
