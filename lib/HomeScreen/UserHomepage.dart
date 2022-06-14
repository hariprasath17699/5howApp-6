// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:localstorage/localstorage.dart';
//
// class UserHomePage extends StatefulWidget {
//   UserHomePage();
//
//   @override
//   _UserHomePageState createState() => _UserHomePageState();
// }
//
// class _UserHomePageState extends State<UserHomePage>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController;
//   ScrollController _scrollViewController;
//   final LocalStorage storage = new LocalStorage('Star');
//   _UserHomePageState();
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(vsync: this, length: 2);
//     _scrollViewController = ScrollController(initialScrollOffset: 0.0);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _scrollViewController.dispose();
//     super.dispose();
//   }
//
//   User user = FirebaseAuth.instance.currentUser;
//   @override
//   Widget build(BuildContext context) {
//     var bakery = FirebaseFirestore.instance
//         .collection("users")
//         .where("type", isEqualTo: "star")
//         .where("interest", isEqualTo: storage.getItem("interest"));
//     return SingleChildScrollView(
//       controller: _scrollViewController,
//       child: StreamBuilder(
//           stream: bakery.snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return Text("Something went wrong");
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Text("Loading");
//             } else {
//               return GridView.count(
//                 physics: ClampingScrollPhysics(),
//                 crossAxisCount: 2,
//                 shrinkWrap: true,
//                 // ignore: deprecated_member_use
//                 children:
//                     snapshot.data.documents.map((DocumentSnapshot document) {
//                   storage.setItem("interest", document.data()["interest"]);
//                   return Card(
//                       elevation: 5,
//                       child: InkWell(
//                           onTap: () {
//                             // Navigator.pushNamed(context, RouteNames.editBakery);
//                           },
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: SizedBox(
//                                       child: Image.network(
//                                         document.data()["Img"].toString(),
//                                         width: 100.0,
//                                         height: 100.0,
//                                       ), // child: Image.network(
//                                       //   document.data()["image_logo"],
//                                       //   width: 100.0,
//                                       //   height: 100.0,
//                                       // ),
//                                     )),
//                                 ListTile(
//                                     title: Center(
//                                         child: Text(document.data()["name"],
//                                             style: TextStyle(fontSize: 20.0))),
//                                     dense: true,
//                                     trailing: SizedBox(
//                                       height: 15,
//                                       width: 15,
//                                     )),
//                               ])));
//                 }).toList(),
//               );
//             }
//           }),
//     );
//   }
// }
