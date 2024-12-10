import 'dart:convert';

import 'package:face_count/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  final List<String> imageUrls;
  final int maleCount; // Jumlah male
  final int femaleCount; // Jumlah female

  const ResultPage({
    Key? key,
    required this.imageUrls,
    required this.maleCount,
    required this.femaleCount,
  }) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<String> imageUrls = []; // URL gambar hasil olahan dari backend
  bool isLoading = true; // For showing loading state

  @override
  void initState() {
    super.initState();
    fetchProcessedImages();
  }

  Future<void> fetchProcessedImages() async {
    try {
      final response = await http
          .get(Uri.parse('http://172.24.161.222:5000/processed-images'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          imageUrls = List<String>.from(data['processed_images']);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load images');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/arrow_back.png',
            color: neutral950,
            width: 28,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Text(
          'Edit Profil',
          style: mediumTS.copyWith(fontSize: 20, color: neutral950),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Partisipan",
              style: regularTS.copyWith(fontSize: 18, color: neutral950),
            ),
            const SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: neutral50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: neutral100,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Column(
                children: ListTile.divideTiles(
                  context: context,
                  color: neutral100,
                  tiles: [
                    ListTile(
                      leading: const Icon(Icons.male),
                      title: Text("${widget.maleCount} orang"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.female),
                      title: Text('${widget.femaleCount} orang'),
                    ),
                  ],
                ).toList(),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              "Foto",
              style: regularTS.copyWith(fontSize: 18, color: neutral950),
            ),
            const SizedBox(height: 8.0),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 gambar per baris
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
                        print(imageUrls[index]);
                        return Image.network(
                          'http://172.24.161.222:5000/${imageUrls[index]}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Text(
                                'Failed to load image',
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
