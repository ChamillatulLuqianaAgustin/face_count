import 'package:face_count/configs/theme.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final List<String> imageUrls; // URL gambar hasil olahan dari backend
  final int maleCount; // Jumlah male
  final int femaleCount; // Jumlah female

  const ResultPage({
    Key? key,
    required this.imageUrls,
    required this.maleCount,
    required this.femaleCount,
  }) : super(key: key);

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
                      title: Text("$maleCount orang"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.female),
                      title: Text('$femaleCount orang'),
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
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 gambar per baris
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    'http://172.24.161.222:5000/static/processed/1000000034.jpg',
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
