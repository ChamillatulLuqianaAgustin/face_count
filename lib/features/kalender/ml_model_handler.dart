// import 'dart:io';
// import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';

// class MLModelHandler {
//   Interpreter? interpreter;

//   Future<void> initializeModel() async {
//     try {
//       // Unduh model dari Firebase
//       FirebaseCustomModel model =
//           await FirebaseModelDownloader.instance.getModel(
//         "Gender-Clas", // Ganti dengan nama model Anda
//         FirebaseModelDownloadType.latestModel,
//         FirebaseModelDownloadConditions(
//           iosAllowsCellularAccess: true,
//           androidChargingRequired: false,
//         ),
//       );

//       // Dapatkan path file model
//       File modelFile = model.file;

//       // Load model dengan TFLite Interpreter
//       interpreter = Interpreter.fromFile(modelFile);
//     } catch (e) {
//       print("Error initializing the model: $e");
//     }
//   }

//   List<dynamic> runModel(List<List<List<int>>> imageInput) {
//     if (interpreter == null) {
//       throw Exception("Model not initialized");
//     }

//     var output = List.filled(1 * 1, 0).reshape([1, 1]);
//     interpreter!.run(imageInput, output);
//     return output;
//   }
// }
