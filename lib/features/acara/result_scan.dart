import 'package:face_count/configs/theme.dart';
import 'package:flutter/material.dart';

class ScanResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 8),
            Text(
              'Hasil Scan',
              style: mediumTS.copyWith(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Partisipan',
              style: regularTS.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
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
                      title: const Text('70 orang'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.female),
                      title: const Text('30 orang'),
                    ),
                  ],
                ).toList(),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Foto',
              style: regularTS.copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 9, // Adjust the number of photos as needed
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/result_scan.png',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
