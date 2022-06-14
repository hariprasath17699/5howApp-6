// import 'package:adobe_xd/page_link.dart';
// import 'package:adobe_xd/pinned.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import 'package:star_event/HomeScreen/Admin/AdminHomePage.dart';
// import 'package:star_event/HomeScreen/Homepage.dart';
// import 'package:star_event/Responsive/ForgotPassword.dart';
// import 'package:star_event/Responsive/Response.dart';
// import 'package:star_event/StarHomePage/StarHome.dart';
//
// import 'EmailVerification/UserEmailVerification.dart';
// import 'UserSignup.dart';
//
// class Loginscreen extends StatefulWidget {
//   @override
//   _LoginscreenState createState() => _LoginscreenState();
// }
//
// class _LoginscreenState extends State<Loginscreen> {
//   final _formKey = GlobalKey<FormState>();
//   final LocalStorage storage = new LocalStorage('Star');
//
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   late String email, password;
//   String message = "";
//   bool loading = false;
//
//   Future loginUser(String email, String password) async {
//     setState(() {
//       loading = true;
//     });
//     String url =
//         "https://starappeprodix.000webhostapp.com/starapp/userLogin.php";
//     Dio dio = new Dio();
//     var fields = {'email': email, 'password': password};
//     FormData formData = new FormData.fromMap(fields);
//     var resp;
//     storage.setItem("email", email);
//     storage.setItem("password", password);
//     var response = await dio.post(url, data: formData);
//     print(response);
//     resp = response.data;
//     setState(() {
//       loading = false;
//     });
//     return response;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     SizeConfig().init(context);
//     // Future<bool?>? _onWillPop() async {
//     //   return showDialog(
//     //         context: context,
//     //         builder: (context) => AlertDialog(
//     //           title: Text('Are you sure?'),
//     //           content: Text('Do you want to exit an App'),
//     //           actions: <Widget>[
//     //             FlatButton(
//     //               onPressed: () => Navigator.of(context).pop(false),
//     //               child: Text('No'),
//     //             ),
//     //             FlatButton(
//     //               onPressed: () => exit(0),
//     //               /*Navigator.of(context).pop(true)*/
//     //               child: Text('Yes'),
//     //             ),
//     //           ],
//     //         ),
//     //       ) ??
//     //       false;
//     // }
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: const Color(0xffffffff),
//       body: SafeArea(
//         child: ResponsiveBuilder(builder: (context, sizingInformation) {
//           if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
//             return Form(
//               key: _formKey,
//               child: Stack(
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.only(
//                         left: MediaQuery.of(context).size.width / 10,
//                         right: MediaQuery.of(context).size.width / 60,
//                         bottom: MediaQuery.of(context).size.height / 60,
//                         top: MediaQuery.of(context).size.height / 15),
//                     child: SvgPicture.asset(
//                       ("assets/images/tab.svg"),
//                       allowDrawingOutsideViewBox: true,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         left: SizeConfig.screenWidth / 10,
//                         right: SizeConfig.screenWidth / 20,
//                         bottom: SizeConfig.screenHeight / 20,
//                         top: SizeConfig.screenHeight / 50),
//                     child: Pinned.fromPins(
//                       Pin(size: 175.7, middle: 0.4993),
//                       Pin(size: 45.9, middle: 0.6351),
//                       child: PageLink(
//                         links: [
//                           // PageLinkInfo(
//                           //   transition: LinkTransition.SlideLeft,
//                           //   ease: Curves.slowMiddle,
//                           //   duration: 0.3,
//                           //   pageBuilder: () => MobileVerification(),
//                           // ),
//                         ],
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(76.51),
//                             color: const Color(0xebfe7607),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height / 18,
//                       left: MediaQuery.of(context).size.width / 25,
//                       right: MediaQuery.of(context).size.width / 20,
//                       bottom: MediaQuery.of(context).size.height / 8,
//                     ),
//                     child: Pinned.fromPins(
//                       Pin(size: 34.0, middle: 0.2881),
//                       Pin(size: 19.0, start: 20.2),
//                       child: Text(
//                         'Login',
//                         style: TextStyle(
//                           fontFamily: 'Poppins-Regular',
//                           fontSize: 12,
//                           color: const Color(0xffffffff),
//                           height: 1.2142857142857142,
//                         ),
//                         textHeightBehavior:
//                             TextHeightBehavior(applyHeightToFirstAscent: false),
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         bottom: SizeConfig.screenHeight / 6,
//                         top: SizeConfig.screenHeight / 200,
//                         left: SizeConfig.screenWidth / 10,
//                         right: SizeConfig.screenWidth / 10),
//                     child: Pinned.fromPins(
//                       Pin(size: 89.0, middle: 0.5400),
//                       Pin(size: 17.0, middle: 0.5586),
//                       child: FractionallySizedBox(
//                         widthFactor: 2.2,
//                         heightFactor: 2.2,
//                         child: FlatButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => ForgotPassword()));
//                           },
//                           child: Text(
//                             'Forget Password',
//                             style: TextStyle(
//                               fontFamily: 'Poppins',
//                               fontSize: 10,
//                               color: const Color(0xff000000),
//                               fontWeight: FontWeight.w300,
//                               height: 1.3076923076923077,
//                             ),
//                             textHeightBehavior: TextHeightBehavior(
//                                 applyHeightToFirstAscent: false),
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height / 18,
//                       left: MediaQuery.of(context).size.width / 10,
//                       right: MediaQuery.of(context).size.width / 80,
//                       bottom: MediaQuery.of(context).size.height / 8,
//                     ),
//                     child: Pinned.fromPins(
//                       Pin(size: 45.0, middle: 0.6969),
//                       Pin(size: 19.0, start: 20.2),
//                       child: FractionallySizedBox(
//                         widthFactor: 2.2,
//                         heightFactor: 2.2,
//                         child: FlatButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SignUPscreen()));
//                           },
//                           child: Text(
//                             'SignUp',
//                             style: TextStyle(
//                               fontFamily: 'Poppins-Regular',
//                               fontSize: 12,
//                               color: const Color(0xff000000),
//                               height: 1.2142857142857142,
//                             ),
//                             textHeightBehavior: TextHeightBehavior(
//                                 applyHeightToFirstAscent: false),
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         left: SizeConfig.screenWidth / 10,
//                         right: SizeConfig.screenWidth / 20,
//                         bottom: SizeConfig.screenHeight / 11,
//                         top: SizeConfig.screenHeight / 11),
//                     child: Pinned.fromPins(
//                       Pin(size: 39.0, middle: 0.4957),
//                       Pin(size: 19.0, middle: 0.6298),
//                       child: FractionallySizedBox(
//                         widthFactor: 2.2,
//                         heightFactor: 2.2,
//                         child: FlatButton(
//                           onPressed: () async {
//                             if (_formKey.currentState!.validate()) {
//                               String email = emailController.text;
//                               String password = passwordController.text;
//                               setState(() {
//                                 message = 'Please Wait....';
//                               });
//                               var rsp = await loginUser(email, password);
//
//                               // var rest = rsp["name"]["name"];
//                               // print(rest);
//                               storage.setItem("user", "true");
//
//                               print("responce: ${rsp}");
//                               print(rsp.toString().contains("true"));
//                               if (rsp.toString().contains("not verifed")) {
//                                 showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return AlertDialog(
//                                       title: new Text("User Not Verified",
//                                           style: TextStyle(
//                                               fontSize: 20.0,
//                                               fontFamily: 'ROGFontsv',
//                                               color: Colors.black)),
//                                       actions: <Widget>[
//                                         FlatButton(
//                                           child: new Text("OK",
//                                               style: TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontFamily: 'ROGFontsv',
//                                                   color: Colors.black87)),
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                         ),
//                                         FlatButton(
//                                           child: new Text("Verify Now",
//                                               style: TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontFamily: 'ROGFontsv',
//                                                   color: Colors.black87)),
//                                           onPressed: () {
//                                             Navigator.push(context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) {
//                                               return UserEmailVerification(
//                                                 email: email,
//                                               );
//                                             }));
//                                           },
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 );
//                               } else {
//                                 if (rsp.toString().contains("true")) {
//                                   if (rsp.toString().contains("AdminLogin")) {
//                                     Navigator.push(context,
//                                         MaterialPageRoute(builder: (context) {
//                                       return AdminHomepage();
//                                     }));
//                                   } else if (rsp
//                                       .toString()
//                                       .contains("UserLogin")) {
//                                     Navigator.push(context,
//                                         MaterialPageRoute(builder: (context) {
//                                       return Homepage();
//                                     }));
//                                   } else if (rsp
//                                       .toString()
//                                       .contains("StarLogin")) {
//                                     Navigator.push(context,
//                                         MaterialPageRoute(builder: (context) {
//                                       return StarHomepage();
//                                     }));
//                                   }
//                                 } else {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         title: new Text("Invalid Login Details",
//                                             style: TextStyle(
//                                                 fontSize: 20.0,
//                                                 fontFamily: 'ROGFontsv',
//                                                 color: Colors.black)),
//                                         actions: <Widget>[
//                                           FlatButton(
//                                             child: new Text("OK",
//                                                 style: TextStyle(
//                                                     fontSize: 15.0,
//                                                     fontFamily: 'ROGFontsv',
//                                                     color: Colors.black87)),
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//
//                                   setState(() {
//                                     message = 'false';
//                                   });
//                                 }
//                               }
//                             }
//                           },
//                           child: Text(
//                             'SignIn',
//                             style: TextStyle(
//                               fontFamily: 'Poppins-Regular',
//                               fontSize: 12,
//                               color: const Color(0xffffffff),
//                               height: 1.2142857142857142,
//                             ),
//                             textHeightBehavior: TextHeightBehavior(
//                                 applyHeightToFirstAscent: false),
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: SizeConfig.screenHeight / 5,
//                       left: SizeConfig.screenWidth / 20,
//                       right: SizeConfig.screenWidth / 60,
//                       bottom: SizeConfig.screenHeight / 40,
//                     ),
//                     child: Container(
//                       height: 70.0,
//                       padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       child: TextField(
//                         style: TextStyle(color: Colors.black87),
//                         autofocus: false,
//                         obscureText: false,
//                         keyboardType: TextInputType.emailAddress,
//                         controller: emailController,
//                         cursorColor: Colors.black87,
//                         decoration: InputDecoration(
//                             fillColor: Colors.black87,
//                             labelText: "Your Email",
//                             labelStyle: TextStyle(
//                               color: Colors.black87,
//                               fontSize: 15,
//                             ),
//                             border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(30)),
//                                 borderSide: BorderSide(
//                                   width: 1,
//                                   color: Colors.red,
//                                 ))),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: SizeConfig.screenHeight / 3.5,
//                       left: SizeConfig.screenWidth / 20,
//                       right: SizeConfig.screenWidth / 60,
//                       bottom: SizeConfig.screenHeight / 100,
//                     ),
//                     child: Container(
//                       height: 70.0,
//                       padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       child: TextField(
//                         style: TextStyle(color: Colors.black87),
//                         autofocus: false,
//                         obscureText: false,
//                         keyboardType: TextInputType.emailAddress,
//                         controller: passwordController,
//                         cursorColor: Colors.black87,
//                         decoration: InputDecoration(
//                             fillColor: Colors.black87,
//                             labelText: "Your Password",
//                             labelStyle: TextStyle(
//                               color: Colors.black87,
//                               fontSize: 15,
//                             ),
//                             border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(30)),
//                                 borderSide: BorderSide(
//                                   width: 1,
//                                   color: Colors.red,
//                                 ))),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         bottom: SizeConfig.screenHeight / 5,
//                         right: SizeConfig.screenWidth / 20,
//                         left: SizeConfig.screenWidth / 20,
//                         top: SizeConfig.screenHeight / 20),
//                     child: Pinned.fromPins(
//                       Pin(size: 200.0, middle: 0.5421),
//                       Pin(size: 41.0, middle: 0.5616),
//                       child: PageLink(
//                         links: [
//                           PageLinkInfo(
//                             transition: LinkTransition.SlideRight,
//                             ease: Curves.slowMiddle,
//                             duration: 0.3,
//                             pageBuilder: () => ForgotPassword(),
//                           ),
//                         ],
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(23.0),
//                             border: Border.all(
//                                 width: 0.3, color: const Color(0xffb9bdc0)),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//           throw ("tablet");
//           Text("Tablet");
//         }),
//       ),
//     );
//   }
// }
