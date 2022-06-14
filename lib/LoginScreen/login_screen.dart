// import 'dart:ui';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:star_event/InterestScreen/UserInterestScreen.dart';
// import 'package:star_event/RegisterScreen/Register.dart';
// import 'package:star_event/StarInterestScreen/UserInterestScreen.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController _phoneNumberController = TextEditingController();
//   final _phoneFormKey = GlobalKey<FormState>();
//   final LocalStorage storage = new LocalStorage('Star');
//   void showOTPDialog(
//       String verificationId, int forceResendingToken, FirebaseAuth _auth) {
//     TextEditingController _otpController = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         child: Padding(
//           padding: const EdgeInsets.all(50.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Please Wait until it login "Automatically" or Enter the "One Time Password" which is sent to the phone number.',
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'OTP',
//                 ),
//                 controller: _otpController,
//               ),
//               FlatButton(
//                 onPressed: () async {
//                   final code = _otpController.text.trim();
//                   AuthCredential credential = PhoneAuthProvider.credential(
//                       verificationId: verificationId, smsCode: code);
//                   print("credential $credential");
//                   if (credential != null) {
//                     User user =
//                         await _auth.signInWithCredential(credential).then(
//                               (value) => value.user,
//                             );
//                     if (user != null) {
//                       FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(user.uid)
//                           .get()
//                           .then((value) {
//                         if (value.exists) {
//                           if (value.data()['type'] == 'user') {
//                             Navigator.push(context,
//                                 MaterialPageRoute(builder: (context) {
//                               return UserInterestScreen(
//                                   _phoneNumberController.text);
//                             }));
//                           }
//                           if (value.data()['type'] == 'star') {
//                             Navigator.push(context,
//                                 MaterialPageRoute(builder: (context) {
//                               return StarInterestScreen(
//                                   _phoneNumberController.text);
//                             }));
//                           }
//                         }
//                       });
//                     } else {
//                       Navigator.pop(context);
//                       print("error");
//                     }
//                   } else {
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text("Verify"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _loginWithPhone() async {
//     FocusScope.of(context).unfocus();
//     if (_phoneFormKey.currentState.validate()) {
//       FirebaseAuth _auth = FirebaseAuth.instance;
//       _auth.verifyPhoneNumber(
//         phoneNumber: _phoneNumberController.text.trim(),
//         timeout: Duration(seconds: 60),
//         verificationCompleted: (phoneAuthCredential) async {
//           UserCredential userCredential =
//               await _auth.signInWithCredential(phoneAuthCredential);
//           User user = userCredential.user;
//           if (user != null) {
//             Navigator.pop(context);
//             FirebaseFirestore.instance
//                 .collection('users')
//                 .doc(user.uid)
//                 .get()
//                 .then((value) {
//               if (value.exists) {
//                 if (value.data()['type'] == 'user') {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return UserInterestScreen(_phoneNumberController.text);
//                   }));
//                 }
//                 if (value.data()['type'] == 'star') {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return StarInterestScreen(_phoneNumberController.text);
//                   }));
//                 }
//               }
//             });
//           } else {
//             Navigator.pop(context);
//             print("Error");
//           }
//         },
//         verificationFailed: (error) {
//           print("error.toString() ${error.toString()}");
//           showDialog<String>(
//             context: context,
//             builder: (BuildContext context) => AlertDialog(
//               title: Text("Error in User Login"),
//               actions: [
//                 FlatButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text('Try again!'),
//                 ),
//               ],
//             ),
//           );
//         },
//         codeSent: (verificationId, forceResendingToken) async {
//           showOTPDialog(verificationId, forceResendingToken, _auth);
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context,
//         designSize: Size(2280, 1080), allowFontScaling: true);
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.asset(
//               'images/login_bg.jpg',
//               fit: BoxFit.cover,
//             ),
//             Positioned(
//               top: 0.05.sh,
//               width: 1.sw,
//               child: Center(
//                 child: Text(
//                   'Login',
//                   style: TextStyle(
//                     fontSize: 30,
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 0.2.sh,
//               width: 1.sw,
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Form(
//                   key: _phoneFormKey,
//                   autovalidate: false,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextFormField(
//                           controller: _phoneNumberController,
//                           validator: (value) {
//                             print(value);
//                             if (value.isEmpty) {
//                               return "Please Enter valid Phone Number";
//                             }
//                             if (!value.contains('+')) {
//                               return "Please Enter number with Country code eg(+91)";
//                             }
//                             if (value.length != 10 + 3) {
//                               return "Please Enter valid Phone Number";
//                             }
//                             return null;
//                           },
//                           keyboardType: TextInputType.phone,
//                           inputFormatters: [
//                             new LengthLimitingTextInputFormatter(13)
//                           ],
//                           decoration: InputDecoration(
//                             labelText: 'Phone Number',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Center(
//                           child: SizedBox(
//                             width: 0.3.sw,
//                             height: 65.h,
//                             child: RaisedButton(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(50.0)),
//                               color: Colors.black,
//                               onPressed: _loginWithPhone,
//                               child: Text(
//                                 'Sign In',
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 25.h),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 50, right: 50, top: 300, bottom: 100),
//               child: Container(
//                 alignment: Alignment.center,
//                 padding: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 40.0),
//                 child: RichText(
//                   text: TextSpan(
//                     children: <TextSpan>[
//                       TextSpan(
//                           text: "Don't have an account",
//                           style:
//                               TextStyle(fontSize: 15.0, color: Colors.black)),
//                       TextSpan(
//                           text: ' Register ',
//                           recognizer: new TapGestureRecognizer()
//                             ..onTap = () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Register()));
//                             },
//                           style:
//                               TextStyle(color: Colors.purple, fontSize: 15.0)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
