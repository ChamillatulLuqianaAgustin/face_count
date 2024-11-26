import 'package:flutter/material.dart';
import '../../../configs/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotificationPage(),
    );
  }
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  // Simulasi daftar notifikasi
  final List<Map<String, String>> notifications = const [
    {"title": "Kuliah Tamu", "subtitle": "Kuliah tamu diadakan 30 menit lagi", "date": "16 Sep 2024"},
    {"title": "Seminar Nasional", "subtitle": "Kuliah tamu diadakan 1 hari lagi", "date": "16 Sep 2024"},
    {"title": "Workshop", "subtitle": "Kuliah tamu diadakan 3 hari lagi", "date": "16 Sep 2024"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifikasi"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: notifications.isNotEmpty
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(13), // 0.05 * 255 = 12.75 ≈ 13
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: index == 0
                          ? const Icon(Icons.circle, color: Colors.red, size: 12)
                          : null,
                      title: Text(
                        notification["title"] ?? "",
                        style: index == 0 ? semiboldTS.copyWith(color: Colors.red) : mediumTS,
                      ),
                      subtitle: Text(notification["subtitle"] ?? "", style: regularTS),
                      trailing: Text(notification["date"] ?? "", style: regularTS),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/no_event.png'),
                ],
              ),
            ),
    );
  }
}
