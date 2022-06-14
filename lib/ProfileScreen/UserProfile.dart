// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:star_event/HomeScreen/AdobeXdUi/InterestScreen/UserInterestScreen.dart';
// import 'package:star_event/HomeScreen/AdobeXdUi/UserLogin.dart';
// import 'package:star_event/ProfileScreen/utils/user_preferences.dart';
// import 'package:star_event/ProfileScreen/widget/button_widget.dart';
// import 'package:star_event/ProfileScreen/widget/profile_widget.dart';
//
// import 'AccountSettings/AccountResponse/AccountResponse.dart';
// import 'BecomeAStar/BecomeAStar.dart';
// import 'model/user.dart';
//
// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   // late File imagePicked;
//   final LocalStorage storage = new LocalStorage('Star');
//   void logoutUser() async {
//     storage.clear();
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => Loginscreen()));
//   }
//
//   @override
//   void initState() {
//     AccountResponse();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = UserPreferences.myUser;
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.logout,
//               color: Colors.red,
//             ),
//             onPressed: () {
//               logoutUser();
//             },
//           ),
//         ],
//       ),
//       body: ListView(
//         physics: BouncingScrollPhysics(),
//         children: [
//           ProfileWidget(
//             imagePath: user.imagePath,
//             onClicked: () async {},
//           ),
//           const SizedBox(height: 24),
//           buildName(user),
//           const SizedBox(
//             height: 24,
//           ),
//           Center(child: buildUpgradeButton()),
//           const SizedBox(height: 24),
//           Center(child: buildAccountSettingsButton()),
//           const SizedBox(height: 24),
//           Center(child: buildInterestButton()),
//         ],
//       ),
//     );
//   }
//
//   Widget buildName(User user) => Column(
//         children: [
//           Text(
//             user.name,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             user.email,
//             style: TextStyle(color: Colors.grey),
//           )
//         ],
//       );
//
//   Widget buildUpgradeButton() => ButtonWidget(
//         text: '   Are You A Star  ',
//         onClicked: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => Becomeastar()));
//         },
//       );
//   Widget buildAccountSettingsButton() => ButtonWidget(
//         text: ' Account Settings',
//         onClicked: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => AccountResponse()));
//         },
//       );
//   Widget buildInterestButton() => ButtonWidget(
//         text: '        Interest         ',
//         onClicked: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => InterestIn1()));
//         },
//       );
// }
