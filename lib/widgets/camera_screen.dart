import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../configs/theme.dart'; // Pastikan file ini diimpor dengan benar.

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller; // Controller dapat null
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  /// Fungsi untuk inisialisasi kamera
  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );

      // Inisialisasi kamera dan set future-nya
      _initializeControllerFuture = _controller!.initialize();
      setState(() {}); // Trigger UI rebuild setelah inisialisasi
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose(); // Jangan lupa dispose controller
    super.dispose();
  }

  /// Fungsi untuk mengambil gambar
  Future<void> _takePicture() async {
    try {
      if (_controller == null || !_controller!.value.isInitialized) {
        print("Controller is not initialized.");
        return;
      }

      // Tunggu kamera selesai inisialisasi
      await _initializeControllerFuture;

      // Ambil gambar
      final picture = await _controller!.takePicture();

      // Tangani gambar (simpan, tampilkan, dll.)
      print("Picture saved at: ${picture.path}");
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Tampilkan kamera jika selesai inisialisasi
            return AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: CameraPreview(_controller!),
            );
          } else if (snapshot.hasError) {
            // Tampilkan pesan error jika ada kesalahan
            return Center(child: Text("Error initializing camera"));
          } else {
            // Tampilkan loading indicator saat kamera belum siap
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
