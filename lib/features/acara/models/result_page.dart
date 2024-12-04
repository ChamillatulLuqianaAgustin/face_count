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
        title: const Text("Prediction Results"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Results Summary",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0),
            Text(
              "Male Count: $maleCount",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Female Count: $femaleCount",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24.0),
            Text(
              "Processed Images",
              style: Theme.of(context).textTheme.titleLarge,
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
                    imageUrls[index],
                    fit: BoxFit.cover,
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
