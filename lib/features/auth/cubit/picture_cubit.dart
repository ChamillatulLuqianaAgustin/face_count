import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_count/features/acara/cubit/acara/acara_state.dart';
import 'package:face_count/services/acara_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PictureCubit extends Cubit<AcaraState> {
  final AcaraService _acara;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  PictureCubit(this._acara) : super(AcaraInitial());

  // Fetch acara list
  Future<void> fetchPicture() async {
    emit(AcaraLoading());
    try {
      final listAcara = await _acara.getAcara(userId!);
      emit(AcaraLoaded(listAcara));
    } catch (e) {
      emit(AcaraError(e.toString()));
    }
  }

  // Add acara
  Future<void> addPicture(List<String> imagesPath, String odAcara) async {
    emit(AcaraLoading());
    try {
      CollectionReference acaraPhotosCollection = FirebaseFirestore.instance
          .collection('acara')
          .doc(odAcara)
          .collection('photos');
      for (String image in imagesPath) {
        await acaraPhotosCollection.add({'url': image});
      }
      emit(AddAcaraSuccess());
      fetchPicture(); // Fetch acara after adding new one
    } catch (e) {
      emit(AcaraError(e.toString()));
    }
  }
}
