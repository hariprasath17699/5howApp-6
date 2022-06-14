// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:star_event/HomeScreen/Homepage.dart';
// import 'Model/InterestModel.dart';
//
// class StarVerificationScreen extends StatefulWidget {
//   static final routeName = '/addCakes';
//   final StarVerification interest;
//   final String text;
//
//   const StarVerificationScreen({
//     Key key,
//     this.text,
//     this.interest,
//   }) : super(key: key);
//
//   @override
//   _StarVerificationScreenState createState() =>
//       _StarVerificationScreenState(text);
// }
//
// class _StarVerificationScreenState extends State<StarVerificationScreen> {
//   final String text;
//
//   _StarVerificationScreenState(
//     this.text,
//   );
//   Color _colorFromHex(String hexColor) {
//     var hexCode = hexColor.replaceAll('Color(0x', '');
//     hexCode = hexCode.replaceAll(')', '');
//     return Color(int.parse('$hexCode', radix: 16));
//   }
//
//   final _addCakesScreenFormKey = GlobalKey<FormState>();
//   String id;
//   TextEditingController _facebookCtrl = TextEditingController();
//   TextEditingController _InstaIdCtrl = TextEditingController();
//   TextEditingController _interestCtrl = TextEditingController();
//   PickedFile imagePicked;
//
//
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context,
//         designSize: Size(2280, 1080), allowFontScaling: true);
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Verification'),
//           backgroundColor: Colors.black,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return Homepage();
//               }));
//             },
//           ),
//         ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//               child: Container(
//             child: Center(
//               child: Form(
//                 key: _addCakesScreenFormKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     buildFacebookID(),
//                     buildInsta(),
//                     buildSubmitButton(context),
//                   ],
//                 ),
//               ),
//             ),
//           )),
//         ),
//       ),
//     );
//   }
//
//   buildImage() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         if (imagePicked != null)
//           SizedBox(
//             width: 200.h,
//             height: 200.h,
//             child: Image.file(File(imagePicked.path)),
//           ),
//         RaisedButton(
//           child: Text("Pick Image/Logo"),
//           onPressed: () async {
//             var image =
//                 await ImagePicker().getImage(source: ImageSource.gallery);
//             setState(() {
//               imagePicked = image;
//             });
//           },
//         ),
//       ],
//     );
//   }
//
//   Padding buildSubmitButton(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Align(
//         alignment: Alignment.bottomRight,
//         child: RaisedButton(
//             color: Colors.green,
//             child: Text(
//               "Get Started",
//               style: TextStyle(color: Colors.white),
//             ),
//             onPressed: () {
//               FocusScope.of(context).unfocus();
//               if (_addCakesScreenFormKey.currentState.validate()) {
//                 print('imagePicked $imagePicked');
//                 createVerification();
//               }
//             }),
//       ),
//     );
//   }
//
//   createVerification() {
//     StarVerification star = StarVerification(
//       InstaID: _InstaIdCtrl.text,
//       FacebookID: _facebookCtrl.text,
//       id: id,
//     );
//     StarVerificationServices().addStarVerification(star)
//         // DocumentReference documentReference = Firestore.instance.collection('Cakes').document();
//         // documentReference
//         //     .set({
//         //   'Cake_Name': _nameCtrl.text,
//         //   'Img': link,
//         //   'Price': _priceCtrl.text,
//         //   'preparation_time' : _timeCtrl.text,
//         //   'id':documentReference.documentID,
//         //   'admin name':widget.adminName,
//         // }
//         //
//         .then((value) {
//       showDialog<void>(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Information'),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   Text('Admin will verify and GetBack.'),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('Ok'),
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return Homepage();
//                   }));
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     });
//   }
//
//   Padding buildFacebookID() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         controller: _facebookCtrl,
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
//           labelText: 'Facebook ID',
//         ),
//       ),
//     );
//   }
//
//   Padding buildInsta() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         controller: _InstaIdCtrl,
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
//           labelText: 'Instagram ID',
//         ),
//       ),
//     );
//   }
// }
