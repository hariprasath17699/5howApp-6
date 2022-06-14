// import 'package:adobe_xd/page_link.dart';
// import 'package:adobe_xd/pinned.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:star_event/Responsive/ForgotPassword.dart';
// import 'package:star_event/StarInterestScreen/UserInterestScreen.dart';
//
// import 'UserLogin.dart';
//
// class StarLoginscreen extends StatefulWidget {
//   @override
//   _StarLoginscreenState createState() => _StarLoginscreenState();
// }
//
// class _StarLoginscreenState extends State<StarLoginscreen> {
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
//         "https://starappeprodix.000webhostapp.com/starapp/starLogin.php";
//     Dio dio = new Dio();
//     var fields = {'email': email, 'password': password};
//     FormData formData = new FormData.fromMap(fields);
//     var resp;
//
//     var response = await dio.post(url, data: formData);
//     print(response);
//     resp = response.data;
//     setState(() {
//       loading = false;
//     });
//
//     return response;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     // Future<bool>? _onWillPop() {
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
//       body: Form(
//         key: _formKey,
//         child: Stack(
//           children: <Widget>[
//             Pinned.fromPins(
//               Pin(size: 175.7, middle: 0.4993),
//               Pin(size: 45.9, middle: 0.6351),
//               child: PageLink(
//                 links: [
//                   // PageLinkInfo(
//                   //   transition: LinkTransition.SlideLeft,
//                   //   ease: Curves.slowMiddle,
//                   //   duration: 0.3,
//                   //   pageBuilder: () => MobileVerification(),
//                   // ),
//                 ],
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(76.51),
//                     color: const Color(0xebfe7607),
//                   ),
//                 ),
//               ),
//             ),
//             Pinned.fromPins(
//               Pin(size: 89.0, middle: 0.5400),
//               Pin(size: 17.0, middle: 0.5586),
//               child: FractionallySizedBox(
//                 widthFactor: 2.2,
//                 heightFactor: 2.2,
//                 child: FlatButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ForgotPassword()));
//                   },
//                   child: Text(
//                     'Forget Password',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 10,
//                       color: const Color(0xff000000),
//                       fontWeight: FontWeight.w300,
//                       height: 1.3076923076923077,
//                     ),
//                     textHeightBehavior:
//                         TextHeightBehavior(applyHeightToFirstAscent: false),
//                     textAlign: TextAlign.left,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.fromLTRB(20.0, 150.0, 20.0, 0.0),
//               child: Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Center(
//                       child: Text("Star Login",
//                           style: TextStyle(
//                               fontSize: 30.0,
//                               fontFamily: 'ROGFontsv',
//                               color: Colors.black)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Pinned.fromPins(
//               Pin(size: 39.0, middle: 0.4957),
//               Pin(size: 19.0, middle: 0.6298),
//               child: FractionallySizedBox(
//                 widthFactor: 2.2,
//                 heightFactor: 2.2,
//                 child: FlatButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       String email = emailController.text;
//                       String password = passwordController.text;
//                       setState(() {
//                         message = 'Please Wait....';
//                       });
//                       var rsp = await loginUser(email, password);
//
//                       storage.setItem("user", "true");
//                       print("responce: ${rsp}");
//
//                       print(rsp.toString().contains("true"));
//                       if (rsp.toString().contains("true")) {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return StarInterestScreen(emailController.text);
//                         }));
//                       } else {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: new Text("Invalid Login Details",
//                                   style: TextStyle(
//                                       fontSize: 20.0,
//                                       fontFamily: 'ROGFontsv',
//                                       color: Colors.black)),
//                               actions: <Widget>[
//                                 FlatButton(
//                                   child: new Text("OK",
//                                       style: TextStyle(
//                                           fontSize: 15.0,
//                                           fontFamily: 'ROGFontsv',
//                                           color: Colors.black87)),
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//
//                         setState(() {
//                           message = 'false';
//                         });
//                       }
//                     }
//                   },
//                   child: Text(
//                     'SignIn',
//                     style: TextStyle(
//                       fontFamily: 'Poppins-Regular',
//                       fontSize: 12,
//                       color: const Color(0xffffffff),
//                       height: 1.2142857142857142,
//                     ),
//                     textHeightBehavior:
//                         TextHeightBehavior(applyHeightToFirstAscent: false),
//                     textAlign: TextAlign.left,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 260),
//               child: Container(
//                 height: 70.0,
//                 padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 child: TextField(
//                   style: TextStyle(color: Colors.black87),
//                   autofocus: false,
//                   obscureText: false,
//                   keyboardType: TextInputType.emailAddress,
//                   controller: emailController,
//                   cursorColor: Colors.black87,
//                   decoration: InputDecoration(
//                       fillColor: Colors.black87,
//                       labelText: "Your Email",
//                       labelStyle: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 15,
//                       ),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(30)),
//                           borderSide: BorderSide(
//                             width: 1,
//                             color: Colors.red,
//                           ))),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 330),
//               child: Container(
//                 height: 70.0,
//                 padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 child: TextField(
//                   style: TextStyle(color: Colors.black87),
//                   autofocus: false,
//                   obscureText: false,
//                   keyboardType: TextInputType.emailAddress,
//                   controller: passwordController,
//                   cursorColor: Colors.black87,
//                   decoration: InputDecoration(
//                       fillColor: Colors.black87,
//                       labelText: "Your Password",
//                       labelStyle: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 15,
//                       ),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(30)),
//                           borderSide: BorderSide(
//                             width: 1,
//                             color: Colors.red,
//                           ))),
//                 ),
//               ),
//             ),
//             Pinned.fromPins(
//               Pin(size: 200.0, middle: 0.5421),
//               Pin(size: 41.0, middle: 0.5616),
//               child: PageLink(
//                 links: [
//                   PageLinkInfo(
//                     transition: LinkTransition.SlideRight,
//                     ease: Curves.slowMiddle,
//                     duration: 0.3,
//                     pageBuilder: () => ForgotPassword(),
//                   ),
//                 ],
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(23.0),
//                     border:
//                         Border.all(width: 0.3, color: const Color(0xffb9bdc0)),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.only(left: 10.0, top: 350.0, bottom: 40.0),
//               child: RichText(
//                 text: TextSpan(
//                   children: <TextSpan>[
//                     TextSpan(
//                         text: "Need to login as User?",
//                         style: TextStyle(fontSize: 15.0, color: Colors.black)),
//                     TextSpan(
//                         text: ' Sign in ',
//                         recognizer: new TapGestureRecognizer()
//                           ..onTap = () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Loginscreen()));
//                           },
//                         style: TextStyle(color: Colors.orange, fontSize: 15.0)),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
