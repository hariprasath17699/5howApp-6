// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:star_event/Star%20RegisterScreen/StarVerificationScreen/Model/InterestModel.dart';
//
// class StarVerificationServices {
//   String adminName;
//   static final StarVerificationServices _cakesService =
//       StarVerificationServices._internal();
//   FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   StarVerificationServices._internal();
//
//   factory StarVerificationServices({String adminName}) {
//     _cakesService.adminName = adminName;
//     return _cakesService;
//   }
//
//   Stream<List<StarVerification>> getStarsverification() {
//     return _db.collection("StarVerification").snapshots().map(
//           (snapshot) => snapshot.documents
//               .map(
//                 (doc) => StarVerification.fromMap(doc.data(), doc.documentID),
//               )
//               .toList(),
//         );
//   }
//
//   Future<void> addStarVerification(StarVerification star) {
//     return _db.collection("StarVerification").add(star.toMap());
//   }
//
//   Future<void> deleteStarVerification(String id) {
//     return _db.collection("StarVerification").document(id).delete();
//   }
//
//   Future<void> updateStarVerification(StarVerification star) {
//     return _db
//         .collection("StarVerification")
//         .document(star.id)
//         .updateData(star.toMap());
//   }
// }
