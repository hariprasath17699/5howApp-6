// import 'package:star_event/HomeScreen/Services/Model/StarModel.dart';
//
// class StarService {
//   String interest;
//   static final StarService _cakesService = StarService._internal();
//
//
//   StarService._internal();
//
//   factory StarService({String interest}) {
//     _cakesService.interest = interest;
//     return _cakesService;
//   }
//
//   Stream<List<Star>> getStars() {
//     return _db
//         .collection("StarInterest")
//         .where('interest', isEqualTo: interest)
//         .snapshots()
//         .map(
//           (snapshot) => snapshot.documents
//               .map(
//                 (doc) => Star.fromMap(doc.data(), doc.documentID),
//               )
//               .toList(),
//         );
//   }
//
//   Future<void> addStar(Star star) {
//     return _db.collection("StarInterest").add(star.toMap());
//   }
//
//   Future<void> deleteStar(String id) {
//     return _db.collection("StarInterest").document(id).delete();
//   }
//
//   Future<void> updateStar(Star star) {
//     return _db
//         .collection("StarInterest")
//         .document(star.id)
//         .updateData(star.toMap());
//   }
// }
