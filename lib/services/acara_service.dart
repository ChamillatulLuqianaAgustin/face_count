import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/acara_model.dart';

class AcaraService {
  Future<List<AcaraModel>> getAcara() async {
    print('Fetching acara data from Firestore...');
    try {
      final snapshot = await FirebaseFirestore.instance.collection('acara').get();
      print('Firestore query successful. Documents found: ${snapshot.docs.length}');
      return snapshot.docs.map((document) {
        return AcaraModel.fromMap(document.data());
      }).toList();
    } catch (e) {
      print('Error fetching acara data: $e');
      rethrow;
    }
  }

  Future<List<AcaraModel>> getAcaraByDate(DateTime date) async {
    print('Fetching acara data for date: $date');
    try {
      // Format the date to remove time components (optional)
      DateTime startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
      DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      final snapshot = await FirebaseFirestore.instance
          .collection('acara')
          .where('date', isGreaterThanOrEqualTo: startOfDay)
          .where('date', isLessThanOrEqualTo: endOfDay)
          .get();

      print('Firestore query successful. Documents found: ${snapshot.docs.length}');
      return snapshot.docs.map((document) {
        return AcaraModel.fromMap(document.data());
      }).toList();
    } catch (e) {
      print('Error fetching acara data by date: $e');
      rethrow;
    }
  }

  Future<void> addAcara(AcaraModel acara) async {
    final CollectionReference acaraCollection = FirebaseFirestore.instance.collection('acara');
    try {
      await acaraCollection.doc(acara.id_acara).set(acara.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
