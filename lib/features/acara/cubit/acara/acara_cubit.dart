import 'package:face_count/models/acara_model.dart';
import 'package:face_count/services/acara_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'acara_state.dart';

class AcaraCubit extends Cubit<AcaraState> {
  final AcaraService _acara;
  AcaraCubit(this._acara) : super(AcaraInitial());

  // Fetch acara list
  Future<void> fetchAcara() async {
    emit(AcaraLoading());
    try {
      final listAcara = await _acara.getAcara();
      emit(AcaraLoaded(listAcara));
    } catch (e) {
      emit(AcaraError(e.toString()));
    }
  }

  // Fetch acara list selesai
  Future<void> fetchAcaraSelesai() async {
    emit(AcaraLoading());
    try {
      final listAcara = await _acara.getAcaraSelesai();
      emit(AcaraLoaded(listAcara));
    } catch (e) {
      emit(AcaraError(e.toString()));
    }
  }

  // Fetch acara by date
  Future<void> getAcaraByDate(DateTime date) async {
    emit(AcaraLoading());
    try {
      final acaraList = await _acara.getAcaraByDate(date);
      print(
          'Acara for ${date.toString()}: ${acaraList.length} found'); // Debug log
      emit(AcaraLoaded(acaraList));
    } catch (e) {
      print('Error fetching acara: $e'); // Debug log
      emit(AcaraError(e.toString()));
    }
  }

  List<AcaraModel> filterRiwayatAcara(List<AcaraModel> acaraList) {
    final now = DateTime.now();
    return acaraList.where((acara) {
      if (acara.tanggalAcara != null) {
        return acara.tanggalAcara!.isBefore(now);
      }
      return false;
    }).toList();
  }

  // Add acara
  Future<void> addAcara({required AcaraModel acara}) async {
    emit(AcaraLoading());
    try {
      await _acara.addAcara(acara);
      print('Acara added: ${acara.namaAcara}, ${acara.tanggalAcara}');
      emit(AddAcaraSuccess());
      fetchAcara(); // Fetch acara after adding new one
    } catch (e) {
      emit(AcaraError(e.toString()));
    }
  }

  // Update acara
  Future<void> updateAcara(AcaraModel acara) async {
    emit(AcaraLoading());
    try {
      await _acara.updateAcara(acara); // Panggil service untuk update
      print('Acara updated: ${acara.namaAcara}, ${acara.tanggalAcara}');
      fetchAcara(); // Ambil ulang acara setelah update
      emit(UpdateAcaraSuccess()); // Emit success state
    } catch (e) {
      emit(AcaraError(e.toString()));
    }
  }

  // Delete acara
  Future<void> deleteAcara(String idAcara) async {
    emit(AcaraLoading());
    try {
      await _acara.deleteAcara(idAcara); // Panggil service untuk hapus
      print('Acara deleted: $idAcara');
      fetchAcara(); // Ambil ulang acara setelah delete
      emit(DeleteAcaraSuccess()); // Emit success state
    } catch (e) {
      emit(AcaraError(e.toString()));
    }
  }
}

// lib/repository/acara_repository.dart
abstract class AcaraRepository {
  Future<List<AcaraModel>> getAcaraList();
  Future<void> createAcara(AcaraModel acara);
  Future<void> updateAcara(AcaraModel acara);
  Future<void> deleteAcara(String idAcara);
}

// lib/repository/acara_repository_impl.dart
class AcaraRepositoryImpl implements AcaraRepository {
  // Add your API client here
  // final ApiClient _apiClient;

  // AcaraRepositoryImpl(this._apiClient);

  @override
  Future<List<AcaraModel>> getAcaraList() async {
    try {
      // Implement API call
      // final response = await _apiClient.get('/acara');
      // return (response.data as List)
      //     .map((json) => Acara.fromJson(json))
      //     .toList();
      return [];
    } catch (e) {
      throw Exception('Failed to fetch acara list: $e');
    }
  }

  @override
  Future<void> createAcara(AcaraModel acara) async {
    try {
      // Implement API call
      // await _apiClient.post('/acara', data: acara.toJson());
    } catch (e) {
      throw Exception('Failed to create acara: $e');
    }
  }

  @override
  Future<void> updateAcara(AcaraModel acara) async {
    try {
      // Implement API call
      // await _apiClient.put('/acara/${acara.idAcara}', data: acara.toJson());
    } catch (e) {
      throw Exception('Failed to update acara: $e');
    }
  }

  @override
  Future<void> deleteAcara(String idAcara) async {
    try {
      // Implement API call
      // await _apiClient.delete('/acara/$idAcara');
    } catch (e) {
      throw Exception('Failed to delete acara: $e');
    }
  }
}
