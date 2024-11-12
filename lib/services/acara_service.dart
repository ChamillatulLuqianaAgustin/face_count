import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/acara_model.dart';

class AcaraService {
  Future<List<AcaraModel>> getAcara() async {
    print('Fetching acara data from Firestore...');
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('acara').get();
      print(
          'Firestore query successful. Documents found: ${snapshot.docs.length}');
      return snapshot.docs.map((document) {
        return AcaraModel.fromMap(document.data());
      }).toList();
    } catch (e) {
      print('Error fetching acara data: $e');
      rethrow;
    }
  }

  Future<void> addAcara(AcaraModel acara) async {
    final CollectionReference userOrders =
        FirebaseFirestore.instance.collection('acara');

    try {
      await userOrders.doc(acara.id_acara).set(acara.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
