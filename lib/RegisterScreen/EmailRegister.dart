// import 'dart:convert';
//
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:localstorage/localstorage.dart';
// import 'package:star_event/HomeScreen/Json/UserHomePageFromJson.dart';
// import 'package:star_event/LoginScreen/EmailLogin.dart';
//
// class RegisterEmail extends StatefulWidget {
//   @override
//   _RegisterEmailState createState() => _RegisterEmailState();
// }
//
// class _RegisterEmailState extends State<RegisterEmail> {
//   final _formKey = GlobalKey<FormState>();
//   final LocalStorage storage = new LocalStorage('star');
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
//     var url =
//         Uri.parse("http://192.168.29.103/StarLoginAndRegister/userLogin.php");
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
//         return UserHomeJson();
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
//     String phoneNumber = phoneController.text;
//     String DateOfBirth = dobController.text;
//
//     List err = [];
//     if (fullName.length < 1) {
//       err.add("Name cannot be empty!");
//     }
//     if (password.length < 8) {
//       err.add("Minimum 8 digit password is required!");
//     }
//     if (phoneNumber.length < 10) {
//       err.add("Phone number should be a 10 digit numeric value");
//     }
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
//           "http://192.168.29.103/StarLoginAndRegister/userRegister.php");
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
//         'interest': "music",
//         'country': "india",
//         'image': "not selected"
//       });
//       print("ERROR : " + response.body);
//       print(response.statusCode);
//       print(response.body);
//       print("${response.statusCode}");
//       print("${response.body}");
//       var dataRecieved = json.decode(response.body);
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
//                             builder: (context) => LoginScreenEmail()));
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
//   // var url = C.API + 'signup';
//   // var response = await http.post(url, headers: {
//   //   "User-Agent": C.UAGENT,  }, body: {
//   //   'fullName': fullName,
//   //   'password': password,
//   //   'email': email,
//   //   'phoneNumber': phoneNumber,
//   //   'passportNumber' : passportNumber,
//   // });
//   // var data = jsonDecode(response.body);
//   // if(response.body.isNotEmpty) {
//   //   json.decode(response.body);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
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
//                       color: Colors.black,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Container(
//                             padding: EdgeInsets.only(top: 10.0),
//                             child: IconButton(
//                                 color: Colors.white,
//                                 icon: Icon(Icons.arrow_back_ios),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 }),
//                           ),
//                           Container(
//                             height: 100.0,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Center(
//                                   child: Container(
//                                     padding: EdgeInsets.fromLTRB(
//                                         20.0, 10.0, 20.0, 0.0),
//                                     child: RichText(
//                                       text: TextSpan(
//                                         children: <TextSpan>[
//                                           TextSpan(
//                                               text: "Sign Up",
//                                               style: TextStyle(
//                                                   fontSize: 20.0,
//                                                   fontFamily: 'ROGFontsv',
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.orange)),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   padding:
//                                       EdgeInsets.fromLTRB(0, 0, 20.0, 20.0),
//                                   child: Image.asset(
//                                     'assets/register.png',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       )),
//                   Container(
//                     height: 70.0,
//                     padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
//                     child: TextField(
//                       keyboardType: TextInputType.text,
//                       controller: fullnameController,
//                       decoration: InputDecoration(
//                           labelText: "FullName",
//                           labelStyle: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                           ),
//                           border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(40)),
//                               borderSide: BorderSide(
//                                   width: 1,
//                                   color: Colors.white,
//                                   style: BorderStyle.solid))),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15.0,
//                   ),
//                   Container(
//                     height: 70.0,
//                     padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
//                     child: TextField(
//                       keyboardType: TextInputType.text,
//                       controller: usernameController,
//                       decoration: InputDecoration(
//                           labelText: "Username",
//                           labelStyle: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                           ),
//                           border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(40)),
//                               borderSide: BorderSide(
//                                   width: 1,
//                                   color: Colors.white,
//                                   style: BorderStyle.solid))),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15.0,
//                   ),
//                   Container(
//                     height: 70.0,
//                     padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                     child: TextField(
//                       autofocus: false,
//                       obscureText: false,
//                       keyboardType: TextInputType.emailAddress,
//                       controller: emailController,
//                       decoration: InputDecoration(
//                           labelText: "Email",
//                           labelStyle: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                           ),
//                           border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(40)),
//                               borderSide: BorderSide(
//                                   width: 1,
//                                   color: Colors.white,
//                                   style: BorderStyle.solid))),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15.0,
//                   ),
//                   Container(
//                     height: 70.0,
//                     padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
//                     child: TextField(
//                       keyboardType: TextInputType.text,
//                       controller: dobController,
//                       decoration: InputDecoration(
//                           labelText: "Date Of Birth",
//                           labelStyle: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                           ),
//                           border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(40)),
//                               borderSide: BorderSide(
//                                   width: 1,
//                                   color: Colors.white,
//                                   style: BorderStyle.solid))),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15.0,
//                   ),
//                   Container(
//                     height: 70.0,
//                     padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                     child: TextField(
//                       obscureText: true,
//                       keyboardType: TextInputType.text,
//                       controller: passwordController,
//                       decoration: InputDecoration(
//                           labelText: "Password",
//                           labelStyle: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                           ),
//                           border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(40)),
//                               borderSide: BorderSide(
//                                   width: 1,
//                                   color: Colors.white,
//                                   style: BorderStyle.solid))),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     height: 70.0,
//                     padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                     child: RaisedButton(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(40.0)),
//                       color: Colors.black,
//                       onPressed: _submitCommand,
//                       child: Center(
//                         child: Text(
//                           "Sign Up",
//                           style: TextStyle(color: Colors.white, fontSize: 20.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     padding:
//                         EdgeInsets.only(left: 10.0, top: 15.0, bottom: 40.0),
//                     child: RichText(
//                       text: TextSpan(
//                         children: <TextSpan>[
//                           TextSpan(
//                               text: "Already I have an account",
//                               style: TextStyle(
//                                   fontSize: 15.0, color: Colors.black)),
//                           TextSpan(
//                               text: ' Login ',
//                               recognizer: new TapGestureRecognizer()
//                                 ..onTap = () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               LoginScreenEmail()));
//                                 },
//                               style: TextStyle(
//                                   color: Colors.orange, fontSize: 15.0)),
//                         ],
//                       ),
//                     ),
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
