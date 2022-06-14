// import 'dart:convert';
//
// import 'package:adobe_xd/page_link.dart';
// import 'package:adobe_xd/pinned.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:http/http.dart' as http;
// import 'package:localstorage/localstorage.dart';
// import 'package:star_event/HomeScreen/Homepage.dart';
// import 'package:star_event/Responsive/Response.dart';
//
// import 'EmailVerification/UserEmailVerification.dart';
// import 'UserLogin.dart';
//
// class SignUPscreen extends StatefulWidget {
//   @override
//   _SignUPscreenState createState() => _SignUPscreenState();
// }
//
// class _SignUPscreenState extends State<SignUPscreen> {
//   final _formKey = GlobalKey<FormState>();
//   final LocalStorage storage = new LocalStorage('Star');
//   bool fbLoading = false, gLoading = false;
//   var result;
//   late String _email;
//   late String _password;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   void loginUser(Map data) async {
//     print("login_start");
//     print(data);
//     // String url = "http://192.168.29.103/StarLoginAndRegister/userLogin.php";
//     var url = Uri.parse(
//         "https://starappeprodix.000webhostapp.com/starapp/starLogin.php");
//     final response = await http.post(url, body: data);
//     var rsp = jsonDecode(response.body);
//     print(rsp);
//     setState(() {
//       fbLoading = false;
//       gLoading = false;
//     });
//     if (rsp['success'] == true) {
//       storage.setItem("auth_token", rsp['data']['auth_token']);
//       storage.setItem("user_id", rsp['data']['id']);
//       storage.setItem("user_name", rsp['data']['name']);
//       storage.setItem("user_email", rsp['data']['email']);
//       storage.setItem("user_phone", rsp['data']['phone']);
//       try {
//         storage.setItem(
//             "user_default_address_id", rsp['data']['default_address_id']);
//         storage.setItem(
//             "user_default_address", rsp['data']['default_address']['address']);
//         storage.setItem("user_delivery_pin", rsp['data']['deliery_pin']);
//         storage.setItem("user_lat", rsp['data']['default_address']['latitude']);
//         storage.setItem(
//             "user_long", rsp['data']['default_address']['longitude']);
//         storage.setItem(
//             "user_address_tag", rsp['data']['default_address']['tag']);
//       } catch (e) {
//         storage.setItem("user_default_address_id", 0);
//         storage.setItem("user_default_address", 'Set Location');
//         storage.setItem("user_address_tag", 'Set Location');
//         storage.setItem("user_delivery_pin", '000000');
//         storage.setItem("user_lat", 0);
//         storage.setItem("user_long", 0);
//       }
//
//       storage.setItem("user_wallet_balance", rsp['data']['wallet_balance']);
//
//       Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return Homepage();
//       }));
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: new Text(rsp['data'].toString()),
//             actions: <Widget>[
//               FlatButton(
//                 child: new Text("OK"),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   void _submitCommand() {
//     final form = _formKey.currentState;
//
//     if (form!.validate()) {
//       form.save();
//       register();
//     }
//   }
//
//   final fullnameController = TextEditingController();
//   final usernameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final phoneController = TextEditingController();
//   final dobController = TextEditingController();
//   bool visible = false;
//
//   Future register() async {
//     setState(() {
//       visible = true;
//     });
//
//     String fullName = fullnameController.text;
//     String username = usernameController.text;
//     String password = passwordController.text;
//     String email = emailController.text;
//     String DateOfBirth = dobController.text;
//
//     List err = [];
//     if (fullName.length < 1) {
//       err.add("Name cannot be empty!");
//     }
//     if (password.length < 8) {
//       err.add("Minimum 8 digit password is required!");
//     }
//
//     if (!RegExp(
//             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//         .hasMatch(email)) {
//       err.add("Invalid email id");
//     }
//     // https://stackoverflow.com/questions/50278258/http-post-with-json-on-body-flutter-dart
//     if (err.length > 0) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: new Text("Invalid Field(s)!"),
//             content: new Container(
//                 height: 200,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: err.map((e) {
//                     return Column(children: [
//                       Text(e, style: TextStyle(color: Colors.red)),
//                       SizedBox(height: 10),
//                     ]);
//                   }).toList(),
//                 )),
//             actions: <Widget>[
//               FlatButton(
//                 child: new Text("OK"),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // var url = 'http://192.168.29.103/StarLoginAndRegister/userRegister.php';
//       var url = Uri.parse(
//           "https://starappeprodix.000webhostapp.com/starapp/userRegister.php");
//       // data = {
//       //    'fullName': fullName,
//       //    'username': username,
//       //    'password': password,
//       //    'email': email,
//       //    'mobile': phoneNumber,
//       //  };
//       //encode Map to JSON
//
//       var response = await http.post(url, body: {
//         'fullname': fullName,
//         'username': username,
//         'password': password,
//         'email': email,
//         'dob': DateOfBirth,
//         'interest': "!!!!!!!!!!!!!!!!!",
//         'country': "india",
//         'image': "Not Selected",
//         'Status': "not verifed",
//         'LoginType': "UserLogin",
//         'Proof': "Not Attached",
//         'Phone': "Not Provided",
//         'Platform': "Not Provided",
//         'profilelink': "Not Provided",
//         'interest1': "Not Provided",
//         'interest2': "Not Provided",
//         'interest3': "Not Provided",
//         'interest4': "Not Provided",
//         'interest5': "Not Provided",
//         'starstatus': "",
//         'reason': ""
//       });
//       print("ERROR : " + response.body);
//       print(response.statusCode);
//       print(response.body);
//       print("${response.statusCode}");
//       print("${response.body}");
//       var dataRecieved = jsonDecode(response.body);
//       if (response.body.toString().contains("true")) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: new Text(
//                 "Register Successful",
//                 style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.orange,
//                     fontWeight: FontWeight.bold),
//               ),
//               actions: <Widget>[
//                 FlatButton(
//                   child: new Text("OK"),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => UserEmailVerification(
//                                   email: emailController.text,
//                                 )));
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: new Text(" Error : " + response.body),
//               actions: <Widget>[
//                 FlatButton(
//                   child: new Text("OK"),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       }
//       return dataRecieved;
//     }
//
//     return false;
//     // Showing Alert Dialog with Response JSON.
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: const Color(0xffffffff),
//       body: Form(
//         key: _formKey,
//         child: Stack(
//           children: <Widget>[
//             Pinned.fromPins(
//               Pin(start: 36.8, end: 36.7),
//               Pin(start: 91.9, end: 38.7),
//               child: Stack(
//                 children: <Widget>[
//                   Pinned.fromPins(
//                     Pin(start: 0.0, end: 0.0),
//                     Pin(start: 0.0, end: 0.0),
//                     child: Stack(
//                       children: <Widget>[
//                         Pinned.fromPins(
//                           Pin(start: 0.0, end: 0.0),
//                           Pin(size: 45.9, start: 0.0),
//                           child: SvgPicture.string(
//                             _svg_c7q0zw,
//                             allowDrawingOutsideViewBox: true,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         Pinned.fromPins(
//                           Pin(size: 175.7, end: 0.0),
//                           Pin(size: 45.9, start: 0.0),
//                           child: PageLink(
//                             links: [
//                               PageLinkInfo(
//                                 transition: LinkTransition.SlideLeft,
//                                 ease: Curves.slowMiddle,
//                                 duration: 0.3,
//                                 // pageBuilder: () => Loginscreen(),
//                               ),
//                             ],
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(76.51),
//                                 color: const Color(0xff3c225f),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(
//                               top: SizeConfig.screenHeight / 2,
//                               bottom: SizeConfig.screenHeight / 100),
//                           child: Pinned.fromPins(
//                             Pin(size: 175.7, middle: 0.5269),
//                             Pin(size: 45.9, middle: 0.7864),
//                             child: PageLink(
//                               links: [],
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(76.51),
//                                   color: const Color(0xebfe7607),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Pinned.fromPins(
//                           Pin(size: 34.0, middle: 0.1691),
//                           Pin(size: 19.0, start: 12.3),
//                           child: FractionallySizedBox(
//                             widthFactor: 2.2,
//                             heightFactor: 2.2,
//                             child: FlatButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Loginscreen()));
//                               },
//                               child: Text(
//                                 'Login',
//                                 style: TextStyle(
//                                   fontFamily: 'Poppins-Regular',
//                                   fontSize: 12,
//                                   color: const Color(0xff000000),
//                                   height: 1.2142857142857142,
//                                 ),
//                                 textHeightBehavior: TextHeightBehavior(
//                                     applyHeightToFirstAscent: false),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Pinned.fromPins(
//                           Pin(size: 45.0, middle: 0.7499),
//                           Pin(size: 19.0, start: 12.3),
//                           child: Text(
//                             'SignUp',
//                             style: TextStyle(
//                               fontFamily: 'Poppins-Regular',
//                               fontSize: 14,
//                               color: const Color(0xffffffff),
//                               height: 1.2142857142857142,
//                             ),
//                             textHeightBehavior: TextHeightBehavior(
//                                 applyHeightToFirstAscent: false),
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(
//                               top: SizeConfig.screenHeight / 2.4),
//                           child: Pinned.fromPins(
//                             Pin(size: 50.0, middle: 0.5036),
//                             Pin(size: 19.0, middle: 0.7746),
//                             child: FractionallySizedBox(
//                               widthFactor: 2.2,
//                               heightFactor: 2.2,
//                               child: FlatButton(
//                                 onPressed: _submitCommand,
//                                 child: Text(
//                                   'Register',
//                                   style: TextStyle(
//                                     fontFamily: 'Poppins-Regular',
//                                     fontSize: 12,
//                                     color: const Color(0xffffffff),
//                                     height: 1.2142857142857142,
//                                   ),
//                                   textHeightBehavior: TextHeightBehavior(
//                                       applyHeightToFirstAscent: false),
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: 45),
//                           child: Container(
//                             height: 70.0,
//                             padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
//                             child: TextField(
//                               keyboardType: TextInputType.text,
//                               controller: fullnameController,
//                               decoration: InputDecoration(
//                                   labelText: "FullName",
//                                   labelStyle: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 14,
//                                   ),
//                                   border: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(40)),
//                                       borderSide: BorderSide(
//                                           width: 1,
//                                           color: Colors.white,
//                                           style: BorderStyle.solid))),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: 110),
//                           child: Container(
//                             height: 70.0,
//                             padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
//                             child: TextField(
//                               keyboardType: TextInputType.text,
//                               controller: usernameController,
//                               decoration: InputDecoration(
//                                   labelText: "Username",
//                                   labelStyle: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 14,
//                                   ),
//                                   border: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(40)),
//                                       borderSide: BorderSide(
//                                           width: 1,
//                                           color: Colors.white,
//                                           style: BorderStyle.solid))),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: 185),
//                           child: Container(
//                             height: 70.0,
//                             padding:
//                                 EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                             child: TextField(
//                               autofocus: false,
//                               obscureText: false,
//                               keyboardType: TextInputType.emailAddress,
//                               controller: emailController,
//                               decoration: InputDecoration(
//                                   labelText: "Email",
//                                   labelStyle: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 14,
//                                   ),
//                                   border: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(40)),
//                                       borderSide: BorderSide(
//                                           width: 1,
//                                           color: Colors.white,
//                                           style: BorderStyle.solid))),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: 240),
//                           child: Container(
//                             height: 70.0,
//                             padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
//                             child: TextField(
//                               keyboardType: TextInputType.text,
//                               controller: dobController,
//                               decoration: InputDecoration(
//                                   labelText: "Date Of Birth",
//                                   labelStyle: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 14,
//                                   ),
//                                   border: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(40)),
//                                       borderSide: BorderSide(
//                                           width: 1,
//                                           color: Colors.white,
//                                           style: BorderStyle.solid))),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: 315),
//                           child: Container(
//                             height: 70.0,
//                             padding:
//                                 EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                             child: TextField(
//                               obscureText: true,
//                               keyboardType: TextInputType.text,
//                               controller: passwordController,
//                               decoration: InputDecoration(
//                                   labelText: "Password",
//                                   labelStyle: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 14,
//                                   ),
//                                   border: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(40)),
//                                       borderSide: BorderSide(
//                                           width: 1,
//                                           color: Colors.white,
//                                           style: BorderStyle.solid))),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// const String _svg_c7q0zw =
//     '<svg viewBox="36.8 91.9 316.6 45.9" ><path transform="translate(36.77, 91.89)" d="M 22.93271827697754 0 L 293.6286926269531 0 C 306.2940979003906 0 316.5614013671875 10.26732730865479 316.5614013671875 22.93271827697754 C 316.5614013671875 35.59811019897461 306.2940979003906 45.86543655395508 293.6286926269531 45.86543655395508 L 22.93271827697754 45.86543655395508 C 10.26732730865479 45.86543655395508 0 35.59811019897461 0 22.93271827697754 C 0 10.26732730865479 10.26732730865479 0 22.93271827697754 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_1o8lha =
//     '<svg viewBox="39.5 347.3 310.5 50.4" ><path transform="translate(39.5, 347.28)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_mqj17e =
//     '<svg viewBox="39.5 272.1 310.5 50.4" ><path transform="translate(39.5, 272.1)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#3c225f" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_lpizlm =
//     '<svg viewBox="39.5 198.5 310.5 50.4" ><path transform="translate(39.5, 198.48)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_1qk1q7 =
//     '<svg viewBox="39.5 496.6 310.5 50.4" ><path transform="translate(39.5, 496.55)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_ulafk4 =
//     '<svg viewBox="39.5 422.5 310.5 50.4" ><path transform="translate(39.5, 422.46)" d="M 25.17850685119629 0 L 285.3563842773438 0 C 299.2620849609375 0 310.5348815917969 11.27280044555664 310.5348815917969 25.17850685119629 C 310.5348815917969 39.08421325683594 299.2620849609375 50.35701370239258 285.3563842773438 50.35701370239258 L 25.17850685119629 50.35701370239258 C 11.27280044555664 50.35701370239258 0 39.08421325683594 0 25.17850685119629 C 0 11.27280044555664 11.27280044555664 0 25.17850685119629 0 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_s0gbse =
//     '<svg viewBox="111.3 289.0 1.0 18.0" ><path transform="translate(111.33, 289.01)" d="M 0 0 L 0 17.98464775085449" fill="none" stroke="#212121" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_rs2iqc =
//     '<svg viewBox="85.0 570.0 14.0 14.0" ><path transform="translate(85.0, 570.0)" d="M 0 0 L 14 0 L 14 14 L 0 14 Z" fill="none" stroke="#afb4b7" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_9g7ksu =
//     '<svg viewBox="87.8 573.2 8.3 6.7" ><path transform="translate(-57.5, 414.5)" d="M 145.3333282470703 162.3333282470703 L 148 165.3333282470703 L 153.6666717529297 158.6666717529297" fill="none" stroke="#ed9649" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
