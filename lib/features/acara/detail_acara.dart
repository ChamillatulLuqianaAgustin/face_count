import 'package:flutter/material.dart';
import '../../configs/theme.dart';

class DetailAcara extends StatefulWidget {
  const DetailAcara({super.key});

  @override
  State<DetailAcara> createState() => _DetailAcaraState();
}

class _DetailAcaraState extends State<DetailAcara> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [purpleBase, purple950],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                'assets/images/acara_card_flower.png',
                scale: 2,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Title Section
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Seminar Nasional',
                            style: mediumTS.copyWith(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Tips Belajar Machine Learning',
                            style: regularTS.copyWith(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.edit, color: Colors.white),
                      const SizedBox(width: 12),
                      const Icon(Icons.delete, color: Colors.white),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Event Details
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detail Acara',
                            style: regularTS.copyWith(
                              fontSize: 18,
                              color: neutral950,
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
                                    leading: const Icon(Icons.event),
                                    title: const Text('Selasa, 16 Sep 2024'),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.access_time),
                                    title: const Text('08:00 - 12:00'),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.place),
                                    title: const Text('Auditorium Lt.8'),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.people),
                                    title: const Text('120 orang'),
                                  ),
                                ],
                              ).toList(),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text('Jumlah Pengunjung',
                              style: regularTS.copyWith(
                                  fontSize: 18, color: Colors.black87)),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.camera_alt, color: Colors.white),
          label: Text(
            'Scan Pengunjung',
            style: regularTS.copyWith(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
      ),
    );
  }
}
