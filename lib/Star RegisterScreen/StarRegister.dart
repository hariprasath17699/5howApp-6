// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:star_event/LoginScreen/login_screen.dart';
//
// class StarRegister extends StatefulWidget {
//   static final routeName = '/addUser';
//
//   const StarRegister({Key key}) : super(key: key);
//
//   @override
//   _StarRegisterState createState() => _StarRegisterState();
// }
//
// class _StarRegisterState extends State<StarRegister> {
//   final _addSuperAdminScreenFormKey = GlobalKey<FormState>();
//   TextEditingController _nameCtrl = TextEditingController();
//   TextEditingController _emailCtrl = TextEditingController();
//   Color _colorData = Color(0xFFEC407A);
//   Color currentColor = Color(0xFFEC407A);
//   TextEditingController _phoneCtrl = TextEditingController();
//   String _typeData = 'star';
//   PickedFile imagePicked;
//   TextEditingController _otpCtrl = TextEditingController();
//   bool userCreated = false;
//   User user = FirebaseAuth.instance.currentUser;
//
//   Future _saveDetails(String name, email, phone) async {
//     var url = "http://192.168.29.103/StarAppApi/saveStar.php";
//     final response = await http.post(url, body: {
//       "Name": name,
//       "Email": email,
//       "number": phone,
//       "Country": "india",
//       "Interest": "music",
//       "Image": "",
//     });
//     print(response.statusCode);
//     var res = response.body;
//     if (res == "true") {
//       Navigator.pop(context);
//     } else {
//       print("ERROR : " + res);
//       print(response.statusCode);
//       print(response.body);
//     }
//   }
//
//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _emailCtrl.dispose();
//     _phoneCtrl.dispose();
//     _otpCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Form(
//               key: _addSuperAdminScreenFormKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   buildName(),
//                   buildPhone(),
//                   buildGmail(),
//                   buildSubmitButton(context),
//                   buildLoginButton()
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Padding buildSubmitButton(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Align(
//         alignment: Alignment.bottomRight,
//         child: RaisedButton(
//             color: Theme.of(context).primaryColor,
//             child: Text(
//               "Register",
//               style: TextStyle(color: Colors.white),
//             ),
//             onPressed: () {
//               FocusScope.of(context).unfocus();
//               if (_addSuperAdminScreenFormKey.currentState.validate()) {
//                 createUser();
//               }
//             }),
//       ),
//     );
//   }
//
//   createUser() {
//     bool otp = false;
//     Firebase.initializeApp(
//       options: Firebase.app().options,
//     ).then((authApp) {
//       FirebaseAuth.instanceFor(app: authApp).verifyPhoneNumber(
//         phoneNumber: _phoneCtrl.text.trim(),
//         timeout: Duration(seconds: 60),
//         verificationCompleted: (phoneAuthCredential) {
//           print("Auth Created");
//         },
//         verificationFailed: (error) {
//           print(error);
//         },
//         codeSent: (verificationId, forceResendingToken) {
//           print("Manual");
//
//           showDialog<String>(
//             context: context,
//             builder: (BuildContext context) => AlertDialog(
//               title: Text("Enter OTP"),
//               content: TextFormField(
//                 controller: _otpCtrl,
//                 keyboardType: TextInputType.number,
//               ),
//               actions: [
//                 FlatButton(
//                   onPressed: () {
//                     Navigator.pop(context, true);
//                     AuthCredential credential = PhoneAuthProvider.credential(
//                         verificationId: verificationId, smsCode: _otpCtrl.text);
//                     FirebaseAuth.instanceFor(app: authApp)
//                         .signInWithCredential(credential)
//                         .then((user) {
//                       print("Auth Created");
//                       FirebaseFirestore.instanceFor(app: authApp)
//                           .collection('users')
//                           .doc(user.user.uid)
//                           .set({
//                         'name': _nameCtrl.text,
//                         'type': _typeData,
//                         'email': _emailCtrl.text,
//                         'number': _phoneCtrl.text,
//                         'interest': "music",
//                         'Img': "",
//                         'Country': "india"
//                       }).then((value) {
//                         print("DB Created");
//                         FirebaseAuth.instanceFor(app: authApp).signOut();
//                         showDialog<void>(
//                           context: context,
//                           barrierDismissible: false, // user must tap button!
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: Text('Information'),
//                               content: SingleChildScrollView(
//                                 child: ListBody(
//                                   children: <Widget>[
//                                     Text('User Register successfully.'),
//                                   ],
//                                 ),
//                               ),
//                               actions: <Widget>[
//                                 TextButton(
//                                   child: Text('Ok'),
//                                   onPressed: () {
//                                     setState(() {
//                                       _saveDetails(_nameCtrl.text,
//                                               _emailCtrl.text, _phoneCtrl.text)
//                                           .then((value) => Navigator.push(
//                                                   context, MaterialPageRoute(
//                                                       builder: (context) {
//                                                 return LoginScreen();
//                                               })));
//                                     });
//
//                                     //Navigator.pushNamed(context, RouteNames.superAdminHome);
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       });
//                     });
//                   },
//                   child: Text("Verify"),
//                 ),
//               ],
//             ),
//           ).then((value) => otp = value);
//         },
//         codeAutoRetrievalTimeout: (verificationId) {
//           print(verificationId);
//         },
//       );
//     });
//     if (otp) {
//       Navigator.pop(context);
//     }
//   }
//
//   Padding buildPhone() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         keyboardType: TextInputType.phone,
//         controller: _phoneCtrl,
//         validator: (value) {
//           if (value.isEmpty) {
//             return 'Enter the field';
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           labelText: 'Phone Number',
//         ),
//       ),
//     );
//   }
//
//   Padding buildLoginButton() {
//     return Padding(
//       padding:
//           const EdgeInsets.only(left: 50, right: 50, top: 300, bottom: 100),
//       child: Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 40.0),
//         child: RichText(
//           text: TextSpan(
//             children: <TextSpan>[
//               TextSpan(
//                   text: "Already have an account",
//                   style: TextStyle(fontSize: 15.0, color: Colors.black)),
//               TextSpan(
//                   text: ' Login ',
//                   recognizer: new TapGestureRecognizer()
//                     ..onTap = () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LoginScreen()));
//                     },
//                   style: TextStyle(color: Colors.purple, fontSize: 15.0)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Padding buildGmail() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         controller: _emailCtrl,
//         validator: (value) {
//           if (value.isEmpty) {
//             return 'Enter the field';
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           labelText: 'Email Address',
//         ),
//       ),
//     );
//   }
//
//   Padding buildName() {
//     return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: TextFormField(
//           controller: _nameCtrl,
//           validator: (value) {
//             if (value.isEmpty) {
//               return 'Enter the field';
//             }
//             return null;
//           },
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             labelText: 'Name',
//           ),
//         ));
//   }
// }
