// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:star_event/User/HomePage/Homepage.dart';
//
//
// class UserInterestScreen extends StatefulWidget {
//   static final routeName = '/editBakery';
//   String email;
//
//   UserInterestScreen(this.email);
//
//   @override
//   _UserInterestScreenState createState() => _UserInterestScreenState(email);
// }
//
// class _UserInterestScreenState extends State<UserInterestScreen> {
//   final _editBakeryFormKey = GlobalKey<FormState>();
//   TextEditingController _nameCtrl = TextEditingController();
//   TextEditingController _interestCtrl = TextEditingController();
//   TextEditingController _countryCtrl = TextEditingController();
//   TextEditingController _emailCtrl = TextEditingController();
//   Color _colorData = Color(0xFFEC407A);
//   Color currentColor = Color(0xFFEC407A);
//   TextEditingController _phoneCtrl = TextEditingController();
//   String _typeData = 'user';
//   late File imagePicked;
//   TextEditingController _otpCtrl = TextEditingController();
//   bool userCreated = false;
//   final LocalStorage storage = new LocalStorage('Star');
//   String email;
//
//   _UserInterestScreenState(
//     this.email,
//   );
//
//   Future _updateDetails(
//     String country,
//     interest,
//     File imagePicked,
//   ) async {
//     print('imagePicked $imagePicked');
//     var url = "http://192.168.29.103/StarLoginAndRegister/updateUser.php";
//     Dio dio = new Dio();
//
//     var fields = {
//       'country': country,
//       'interest': "football",
//       'email': email,
//       'image': imagePicked.path
//     };
//     FormData formData = new FormData.fromMap(fields);
//     var resp;
//
//     var response = await dio.post(url, data: formData);
//     print(response.statusCode);
//     print(response.data);
//     var res = response.data;
//     if (res.contains("true")) {
//       Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return Homepage(3);
//       }));
//     } else {
//       print("ERROR : " + res);
//       print(response.statusCode);
//       print(response.data);
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
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Interest Details"),
//         ),
//         body: SingleChildScrollView(
//           child: Form(
//             key: _editBakeryFormKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 buildInterest(),
//                 buildCountry(),
//                 buildImage(),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: RaisedButton(
//                       color: Theme.of(context).primaryColor,
//                       child: Text(
//                         "Update",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () {
//                         if (imagePicked == null) {
//                           showDialog<String>(
//                             context: context,
//                             builder: (BuildContext context) => AlertDialog(
//                               title: Text('Select Image / Logo'),
//                               actions: [
//                                 FlatButton(
//                                   onPressed: () => Navigator.pop(context),
//                                   child: Text('Ok'),
//                                 )
//                               ],
//                             ),
//                           );
//                         } else {
//                           _updateDetails(_countryCtrl.text, _interestCtrl.text,
//                               imagePicked);
//                         }
//                       },
//                     ),
//                   ),
//                 )
//               ],
//             ),
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
//           if (value!.isEmpty) {
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
//   Padding buildCountry() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         controller: _countryCtrl,
//         validator: (value) {
//           if (value!.isEmpty) {
//             return 'Enter the field';
//           }
//           return null;
//         },
//         maxLines: 1,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           labelText: 'Country',
//           alignLabelWithHint: true,
//         ),
//       ),
//     );
//   }
//
//   Padding buildInterest() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         controller: _interestCtrl,
//         validator: (value) {
//           if (value!.isEmpty) {
//             return 'Enter the field';
//           }
//           return null;
//         },
//         maxLines: 1,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           labelText: 'Interest',
//           alignLabelWithHint: true,
//         ),
//       ),
//     );
//   }
//
//   Padding buildPhone() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         keyboardType: TextInputType.phone,
//         controller: _phoneCtrl,
//         validator: (value) {
//           if (value!.isEmpty) {
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
//   buildImage() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         RaisedButton(
//             child: Text("Pick Image/Logo"),
//             onPressed: () async {
//               var imagepicker = await ImagePicker.platform
//                   .pickImage(source: ImageSource.gallery);
//               if (imagepicker != null) {
//                 setState(() {
//                   imagePicked = imagepicker as File;
//                 });
//               }
//             }),
//       ],
//     );
//   }
//
//   Padding buildName() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         controller: _nameCtrl,
//         validator: (value) {
//           if (value!.isEmpty) {
//             return 'Enter the field';
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           labelText: 'Name',
//         ),
//       ),
//     );
//   }
// }
