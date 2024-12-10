import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_count/models/acara_model.dart';
import 'package:face_count/services/acara_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/acara_model.dart';
import 'acara_state.dart';

class PictureCubit extends Cubit<AcaraState> {
  final AcaraService _acara;
  PictureCubit(this._acara) : super(AcaraInitial());

  // Fetch acara list
  Future<void> fetchPicture() async {
    emit(AcaraLoading());
    try {
      final listAcara = await _acara.getAcara();
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
