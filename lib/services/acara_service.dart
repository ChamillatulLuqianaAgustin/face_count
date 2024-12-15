import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/acara_model.dart';

class AcaraService {
  // Mendeklarasikan CollectionReference sekali, agar bisdi seluruh fungsi
  final CollectionReference acaraCollection =
      FirebaseFirestore.instance.collection('acara');


//  Future<List<AcaraModel>> getAcara() async {
//     try {
//       final now = DateTime.now();
//       final todayStart = DateTime(now.year, now.month, now.day);

//       final snapshot = await FirebaseFirestore.instance
//           .collection('acara')
//           .where('waktu_mulai', isGreaterThanOrEqualTo: todayStart)
//           .get();
//       return snapshot.docs.map((document) {
//         return AcaraModel.fromMap(document.data());
//       }).toList();
//     } catch (e) {
//       debugPrint('Error fetching acara data: $e');
//       rethrow;
//     }
//   }

  Future<List<AcaraModel>> getAcara(String userId) async {
    try {
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);

      final snapshot = await acaraCollection
          .where('userId.uid', isEqualTo: userId)
          .where('waktu_mulai', isGreaterThanOrEqualTo: todayStart)
          .get();

      debugPrint(
          'Fetched ${snapshot.docs.length} acara for userId: $userId'); // ini buat debug ygy alhamdulillah aman

      return snapshot.docs.map((doc) {
        return AcaraModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception('Error fetching acara by userId: $e');
    }
  }

  // Fetch all acara selesai
  Future<List<AcaraModel>> getAcaraSelesai(String userId) async {
    try {
      final snapshot = await acaraCollection
          .where('userId.uid', isEqualTo: userId)
          .where('waktu_selesai', isLessThanOrEqualTo: DateTime.now())
          .get();
      return snapshot.docs.map((doc) {
        return AcaraModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      debugPrint('Error fetching acara data: $e');
      rethrow;
    }
  }

  // Fetch acara by date
  Future<List<AcaraModel>> getAcaraByDate(DateTime date, String userId) async {
    debugPrint(
        'Fetching acara data for date: ${DateTime(date.year, date.month, date.day)}');
    try {
      // Format the date to remove time components (optional)
      DateTime startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
      DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      final snapshot = await FirebaseFirestore.instance
          .collection('acara')
          .where('userId.uid', isEqualTo: userId)
          .where('waktu_mulai', isGreaterThanOrEqualTo: startOfDay)
          .where('waktu_mulai', isLessThanOrEqualTo: endOfDay)
          .get();

      debugPrint(
          'Firestore query successful. Documents found: ${snapshot.docs.length}');
      return snapshot.docs.map((document) {
        return AcaraModel.fromMap(document.data());
      }).toList();
    } catch (e) {
      debugPrint('Error fetching acara data by date: $e');
      rethrow;
    }
  }

  //Add acara
  // Future<void> addAcara(AcaraModel acara) async {
  //   try {
  //     await acaraCollection.doc(acara.idAcara).set(acara.toMap());
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  Future<void> addAcara(AcaraModel acara) async {
    try {
      await acaraCollection.doc(acara.idAcara).set(acara.toMap());
    } catch (e) {
      debugPrint('Error adding acara: $e');
      rethrow;
    }
  }

  // Update acara
  Future<void> updateAcara(AcaraModel acara) async {
    try {
      await acaraCollection.doc(acara.idAcara).update(acara.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> updateAcara(AcaraModel acara) async {
  //   try {
  //     final userId = FirebaseAuth.instance.currentUser?.uid;
  //     if (userId == null) throw Exception("User not logged in!");

  //     // Pastikan acara memiliki userId yang sesuai sebelum diperbarui
  //     if (acara.userId?['uid'] != userId) {
  //       throw Exception("Unauthorized to update this acara!");
  //     }

  //     await acaraCollection.doc(acara.idAcara).update(acara.toMap());
  //     debugPrint('Acara updated with id: ${acara.idAcara} for userId: $userId');
  //   } catch (e) {
  //     debugPrint('Error updating acara: $e');
  //     rethrow;
  //   }
  // }

  // Delete acara
  Future<void> deleteAcara(String id) async {
    try {
      await acaraCollection.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  // Get acara as stream for real-time updates
  Stream<List<AcaraModel>> getAcaraStream() {
    return acaraCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return AcaraModel.fromMap(document.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
