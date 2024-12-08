// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';

// class RealtimeDetectionPage extends StatefulWidget {
//   const RealtimeDetectionPage({super.key});

//   @override
//   _RealtimeDetectionPageState createState() => _RealtimeDetectionPageState();
// }

// class _RealtimeDetectionPageState extends State<RealtimeDetectionPage> {
//   CameraController? _cameraController;
//   Interpreter? _interpreter;
//   bool _isProcessingFrame = false;
//   String? _output = "Initializing...";

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//     _loadModel();
//   }

//   // Inisialisasi kamera
//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final camera = cameras.first; // Gunakan kamera depan atau belakang

//     _cameraController = CameraController(
//       camera,
//       ResolutionPreset.medium,
//     );

//     await _cameraController?.initialize();
//     _cameraController?.startImageStream((CameraImage image) {
//       if (_isProcessingFrame) return;
//       _isProcessingFrame = true;

//       _processFrame(image).then((_) {
//         _isProcessingFrame = false;
//       });
//     });

//     setState(() {});
//   }

//   // Load model TFLite dari Firebase
//   Future<void> _loadModel() async {
//     try {
//       FirebaseCustomModel model =
//           await FirebaseModelDownloader.instance.getModel(
//         "Gender-Clas", // Ganti dengan nama model Anda
//         FirebaseModelDownloadType.latestModel,
//         FirebaseModelDownloadConditions(
//           iosAllowsCellularAccess: true,
//           androidChargingRequired: false,
//         ),
//       );

//       _interpreter = Interpreter.fromFile(model.file);
//       setState(() {
//         _output = "Model loaded.";
//       });
//     } catch (e) {
//       setState(() {
//         _output = "Error loading model: $e";
//       });
//     }
//   }

//   // Proses frame kamera
//   Future<void> _processFrame(CameraImage image) async {
//     if (_interpreter == null) return;

//     // Konversi image ke format yang sesuai (misalnya 128x128 RGB)
//     final input = preprocessImage(image);

//     // Siapkan output tensor
//     final output = List.filled(1 * 1, 0).reshape([1, 1]);

//     // Jalankan model
//     _interpreter!.run(input, output);

//     setState(() {
//       _output = "Prediction: ${output[0][0] > 0.5 ? "Male" : "Female"}";
//     });
//   }

//   // Preprocessing gambar
//   List<List<List<int>>> preprocessImage(CameraImage image) {
//     // Convert `image` menjadi ukuran tensor yang sesuai dengan model (misalnya 128x128 RGB)
//     // Contoh: Resize frame kamera menjadi [128, 128, 3]
//     // Implementasi sebenarnya tergantung pada format input model Anda
//     return List.generate(128, (_) => List.generate(128, (_) => [0, 0, 0]));
//   }

//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     _interpreter?.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Realtime Gender Detection")),
//       body: Stack(
//         children: [
//           if (_cameraController != null &&
//               _cameraController!.value.isInitialized)
//             CameraPreview(_cameraController!),
//           Positioned(
//             bottom: 16,
//             left: 16,
//             right: 16,
//             child: Container(
//               padding: EdgeInsets.all(16),
//               color: Colors.black54,
//               child: Text(
//                 _output ?? "Loading...",
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
