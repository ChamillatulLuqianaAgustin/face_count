import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/acara_model.dart';

class AcaraService {
  // Mendeklarasikan CollectionReference sekali, agar bisa digunakan di seluruh fungsi
  final CollectionReference acaraCollection =
      FirebaseFirestore.instance.collection('acara');

  // Fetch all acara
  Future<List<AcaraModel>> getAcara() async {
    try {
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);

      final snapshot = await FirebaseFirestore.instance
          .collection('acara')
          .where('waktu_mulai', isGreaterThanOrEqualTo: todayStart)
          .get();
      return snapshot.docs.map((document) {
        return AcaraModel.fromMap(document.data());
      }).toList();
    } catch (e) {
      debugPrint('Error fetching acara data: $e');
      rethrow;
    }
  }

  // Fetch all acara selesai
  Future<List<AcaraModel>> getAcaraSelesai() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('acara')
          .where('waktu_selesai', isLessThanOrEqualTo: DateTime.now())
          .get();
      return snapshot.docs.map((document) {
        return AcaraModel.fromMap(document.data());
      }).toList();
    } catch (e) {
      debugPrint('Error fetching acara data: $e');
      rethrow;
    }
  }

  // Fetch acara by date
  Future<List<AcaraModel>> getAcaraByDate(DateTime date) async {
    debugPrint(
        'Fetching acara data for date: ${DateTime(date.year, date.month, date.day)}');
    try {
      // Format the date to remove time components (optional)
      DateTime startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
      DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      final snapshot = await FirebaseFirestore.instance
          .collection('acara')
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
  Future<void> addAcara(AcaraModel acara) async {
    try {
      await acaraCollection.doc(acara.idAcara).set(acara.toMap());
    } catch (e) {
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
