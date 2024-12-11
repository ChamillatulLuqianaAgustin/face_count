import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_image_camera/camera_file.dart';
import 'picture_state.dart';

class PictureCubit extends Cubit<PictureState> {
  PictureCubit() : super(PictureInitial());

  // Fetch acara list
  Future<void> fetchPicture(String idAcara) async {
    emit(PictureLoading());
    try {
      final acaraPhotosCollection = await FirebaseFirestore.instance
          .collection('acara')
          .doc(idAcara)
          .collection('photos')
          .get();

      List<String> photoUrls = [];
      for (var doc in acaraPhotosCollection.docs) {
        if (doc.data().containsKey('url')) {
          photoUrls.add(doc['url']);
        }
      }

      emit(PictureLoaded(photoUrls));
    } catch (e) {
      emit(PictureError(e.toString()));
    }
  }

  Future<void> sendImages({
    required String idAcara,
    required List<MediaModel> images,
  }) async {
    final uri = Uri.parse('http://172.23.0.2:5000/predict');
    var request = http.MultipartRequest('POST', uri);

    emit(PictureLoading());
    try {
      for (var image in images) {
        final file = File(image.file.path);
        final multipartFile = await http.MultipartFile.fromPath(
          'images', // Field name in the API
          file.path,
        );
        request.files.add(multipartFile);
      }

      // Kirim request
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final decodedResponse = jsonDecode(responseData.body);

        // Data dari backend
        int maleCount = decodedResponse['male'];
        int femaleCount = decodedResponse['female'];
        List<String> processedImageUrls =
            List<String>.from(decodedResponse['processed_images']);

        addPicture(
          idAcara: idAcara,
          imagesUrls: processedImageUrls,
          maleCount: maleCount,
          femaleCount: femaleCount,
        );
      } else {
        print('Failed to predict. Status code: ${response.statusCode}');
        emit(PictureError(
          'Failed to predict. Status code: ${response.statusCode}',
        ));
      }
    } catch (e) {
      print('Error while sending images: $e');
      emit(PictureError(e.toString()));
    }
  }

  // Add acara
  Future<void> addPicture({
    required List<String> imagesUrls,
    required String idAcara,
    required int maleCount,
    required int femaleCount,
  }) async {
    try {
      DocumentReference acaraDoc =
          FirebaseFirestore.instance.collection('acara').doc(idAcara);

      await acaraDoc.update({
        'male': maleCount,
        'female': femaleCount,
      });

      CollectionReference acaraPhotosCollection = acaraDoc.collection('photos');

      for (String image in imagesUrls) {
        await acaraPhotosCollection.add({'url': image});
      }
      emit(PictureAddSuccess());
    } catch (e) {
      emit(PictureError(e.toString()));
    }
  }
}
