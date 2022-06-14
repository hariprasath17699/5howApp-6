// import 'dart:async';
// import 'dart:ui';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:star_event/InterestScreen/UserInterestScreen.dart';
// import 'package:star_event/LoginScreen/EmailStarLogin.dart';
// import 'package:star_event/RegisterScreen/EmailRegister.dart';
//
// class LoginScreenEmail extends StatefulWidget {
//   @override
//   _LoginScreenEmailState createState() => _LoginScreenEmailState();
// }
//
// class _LoginScreenEmailState extends State<LoginScreenEmail> {
//   final _formKey = GlobalKey<FormState>();
//   final LocalStorage storage = new LocalStorage('star');
//
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   late String email, password;
//   String message = "";
//   bool loading = false;
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   Future loginUser(String email, String password) async {
//     setState(() {
//       loading = true;
//     });
//     String url = "http://192.168.29.103/StarLoginAndRegister/userLogin.php";
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
//     // Future<bool?> _onWillPop() async {
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
//       body: Form(
//         key: _formKey,
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     child: ClipRRect(
//                         child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 4, sigmaY: 2),
//                       child: Container(
//                         color: Colors.black.withOpacity(0.1),
//                         child: Container(
//                           padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 30.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: <Widget>[
//                                     // Text(
//                                     //   "Order from top & favourite",
//                                     //   style: TextStyle(
//                                     //       color: Colors.white,
//                                     //       fontFamily: 'Franklin_Gothic',
//                                     //       fontWeight: FontWeight.bold,
//                                     //       fontSize: 35.0),
//                                     // ),
//                                     Container(
//                                         child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Container(
//                                           padding: EdgeInsets.only(
//                                               top: 1.0, bottom: 80),
//                                           child: IconButton(
//                                               icon: Icon(Icons.arrow_back_ios),
//                                               color: Colors.black,
//                                               onPressed: () {}),
//                                         ),
//                                         Container(
//                                           height: 100.0,
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: <Widget>[
//                                               Flexible(
//                                                   child: Container(
//                                                 padding: EdgeInsets.fromLTRB(
//                                                     20.0, 20.0, 20.0, 0.0),
//                                                 child: Container(
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: <Widget>[
//                                                       Center(
//                                                         child: Text(
//                                                             "User Login",
//                                                             style: TextStyle(
//                                                                 fontSize: 40.0,
//                                                                 fontFamily:
//                                                                     'ROGFontsv',
//                                                                 color: Colors
//                                                                     .black)),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               )),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                                     SizedBox(
//                                       height: 15.0,
//                                     ),
//                                     Container(
//                                       height: 70.0,
//                                       padding: EdgeInsets.fromLTRB(
//                                           20.0, 10.0, 20.0, 10.0),
//                                       child: TextField(
//                                         style: TextStyle(color: Colors.black87),
//                                         autofocus: false,
//                                         obscureText: false,
//                                         keyboardType:
//                                             TextInputType.emailAddress,
//                                         controller: emailController,
//                                         cursorColor: Colors.black87,
//                                         decoration: InputDecoration(
//                                             fillColor: Colors.black87,
//                                             labelText: "Your Email",
//                                             labelStyle: TextStyle(
//                                               color: Colors.black87,
//                                               fontSize: 15,
//                                             ),
//                                             border: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(30)),
//                                                 borderSide: BorderSide(
//                                                   width: 1,
//                                                   color: Colors.red,
//                                                 ))),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15.0,
//                                     ),
//                                     Container(
//                                       height: 70.0,
//                                       padding: EdgeInsets.fromLTRB(
//                                           20.0, 10.0, 20.0, 10.0),
//                                       child: TextField(
//                                         style: TextStyle(color: Colors.black87),
//                                         autofocus: false,
//                                         obscureText: true,
//                                         keyboardType: TextInputType.text,
//                                         controller: passwordController,
//                                         cursorColor: Colors.white,
//                                         decoration: InputDecoration(
//                                             labelText: "Password",
//                                             labelStyle: TextStyle(
//                                               color: Colors.black87,
//                                               fontSize: 16,
//                                             ),
//                                             border: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(30)),
//                                                 borderSide: BorderSide(
//                                                     width: 1,
//                                                     color: Colors.red,
//                                                     style: BorderStyle.solid))),
//                                       ),
//                                     ),
//                                     Container(
//                                         padding: EdgeInsets.fromLTRB(
//                                             20.0, 5.0, 30.0, 0.0),
//                                         alignment: Alignment.bottomRight,
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             // Navigator.push(
//                                             //     context,
//                                             //     MaterialPageRoute(
//                                             //         builder: (context) =>
//                                             //             ForgotPassword()));
//                                           },
//                                           child: Text(
//                                             "Forgot Password?",
//                                             style: TextStyle(
//                                               color: Colors.orange,
//                                             ),
//                                           ),
//                                         )),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Container(
//                                       height: 75.0,
//                                       padding: EdgeInsets.fromLTRB(
//                                           20.0, 15.0, 20.0, 10.0),
//                                       child: RaisedButton(
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(50.0)),
//                                         color: Colors.black,
//                                         onPressed: () async {
//                                           if (_formKey.currentState!
//                                               .validate()) {
//                                             String email = emailController.text;
//                                             String password =
//                                                 passwordController.text;
//                                             setState(() {
//                                               message = 'Please Wait....';
//                                             });
//                                             var rsp = await loginUser(
//                                                 email, password);
//
//                                             storage.setItem("user", "true");
//                                             print("responce: ${rsp}");
//
//                                             print(rsp
//                                                 .toString()
//                                                 .contains("true"));
//                                             if (rsp
//                                                 .toString()
//                                                 .contains("true")) {
//                                               Navigator.push(context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) {
//                                                 return UserInterestScreen(
//                                                     emailController.text);
//                                               }));
//                                             } else {
//                                               showDialog(
//                                                 context: context,
//                                                 builder:
//                                                     (BuildContext context) {
//                                                   return AlertDialog(
//                                                     title: new Text(
//                                                         "Invalid Login Details",
//                                                         style: TextStyle(
//                                                             fontSize: 20.0,
//                                                             fontFamily:
//                                                                 'ROGFontsv',
//                                                             color:
//                                                                 Colors.black)),
//                                                     actions: <Widget>[
//                                                       FlatButton(
//                                                         child: new Text("OK",
//                                                             style: TextStyle(
//                                                                 fontSize: 15.0,
//                                                                 fontFamily:
//                                                                     'ROGFontsv',
//                                                                 color: Colors
//                                                                     .black87)),
//                                                         onPressed: () {
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                       ),
//                                                     ],
//                                                   );
//                                                 },
//                                               );
//
//                                               setState(() {
//                                                 message = 'false';
//                                               });
//                                             }
//                                           }
//                                         },
//                                         child: Center(
//                                           child: (loading)
//                                               ? Center(
//                                                   child:
//                                                       CircularProgressIndicator(
//                                                   valueColor:
//                                                       new AlwaysStoppedAnimation<
//                                                           Color>(Colors.white),
//                                                 ))
//                                               : Text(
//                                                   "Login",
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 20.0),
//                                                 ),
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       alignment: Alignment.center,
//                                       padding: EdgeInsets.only(
//                                           left: 10.0, top: 15.0, bottom: 40.0),
//                                       child: RichText(
//                                         text: TextSpan(
//                                           children: <TextSpan>[
//                                             TextSpan(
//                                                 text:
//                                                     "Don't have an account yet?",
//                                                 style: TextStyle(
//                                                     fontSize: 15.0,
//                                                     color: Colors.black)),
//                                             TextSpan(
//                                                 text: ' Sign up ',
//                                                 recognizer:
//                                                     new TapGestureRecognizer()
//                                                       ..onTap = () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder:
//                                                                     (context) =>
//                                                                         RegisterEmail()));
//                                                       },
//                                                 style: TextStyle(
//                                                     color: Colors.orange,
//                                                     fontSize: 15.0)),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       alignment: Alignment.center,
//                                       padding: EdgeInsets.only(
//                                           left: 10.0, top: 15.0, bottom: 40.0),
//                                       child: RichText(
//                                         text: TextSpan(
//                                           children: <TextSpan>[
//                                             TextSpan(
//                                                 text: "Need to login as Star?",
//                                                 style: TextStyle(
//                                                     fontSize: 15.0,
//                                                     color: Colors.black)),
//                                             TextSpan(
//                                                 text: ' Sign in ',
//                                                 recognizer:
//                                                     new TapGestureRecognizer()
//                                                       ..onTap = () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder:
//                                                                     (context) =>
//                                                                         StarLoginScreenEmail()));
//                                                       },
//                                                 style: TextStyle(
//                                                     color: Colors.orange,
//                                                     fontSize: 15.0)),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
