// import 'dart:io';
// import 'package:face_count/models/acara_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// class ScanPengunjung {
//   Future<AcaraModel?> scanDisease({
//     required String uid,
//     required XFile image,
//   }) async {
//     try {
//       final api = Uri.parse('https://127.0.0.1:5000/predict');

//       // Read image bytes
//       final imageBytes = await image.readAsBytes();

//       // Create multipart request
//       var request = http.MultipartRequest('POST', api);

//       // Add image file to the request
//       request.files.add(
//         http.MultipartFile.fromBytes(
//           'image', imageBytes,
//           filename: image.path.split('/').last,
//           // contentType: MediaType('image', 'jpeg'),
//         ),
//       );

//       // Sending image to model
//       final response = await request.send().then((res) async => await http.Response.fromStream(res));
//       if (response.statusCode == 413) return Left(Exception('Ukuran gambar terlalu besar!')); // If image size to high

//       // Decode the response body
//       final responseBody = jsonDecode(response.body);

//       // If detection is error
//       if (response.statusCode == 400 || response.statusCode == 202) return Left(Exception(responseBody['message']));

//       // If no disease detected
//       if (response.statusCode == 201) return const Right(null);

//       // If any disease detected
//       final path = '/$uid/${image.path.split('/').last}'; // Set for file path (name)
//       await client.storage.from('user_histories').uploadBinary(path, imageBytes); // Upload image to supabase
//       final url = client.storage.from('user_histories').getPublicUrl(path);
//       final disease = await client
//           .from('diseases')
//           .select()
//           .eq('slug', responseBody['data']['label'])
//           .single()
//           .then((ds) => DiseaseModel.fromMap(ds)); // Get the disease data

//       // Send riwayat model
//       final riwayat = RiwayatModel(
//         idUser: uid,
//         idDisease: disease,
//         accuracy: responseBody['data']['confidence'],
//         urlImage: url,
//       );

//       // Return the model
//       final supaResponse = await client.from('histories').insert(riwayat.toMap()).select().single();
//       return Right(riwayat.copyWith(id: supaResponse['id']));
//     } on Exception catch (e) {
//       return Left(e);
//     }
//   }
// }