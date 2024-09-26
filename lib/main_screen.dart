import 'package:face_count/configs/theme.dart';
import 'package:flutter/material.dart';

import 'features/beranda/beranda_page.dart';
import 'features/kalender/kalender_page.dart';
import 'features/profil/profil_page.dart';
import 'features/riwayat/riwayat_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const BerandaPage(),
    const KalenderPage(),
    const RiwayatPage(),
    const ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          children: [
            // Avatar
            const CircleAvatar(
              radius: 24,
              backgroundColor: yellow50,
              backgroundImage: AssetImage('assets/images/memoji.png'),
            ),

            const SizedBox(width: 8),

            // Fill remaining space
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Pagi,',
                    style: regularTS.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Ravi Wimar',
                    style: mediumTS.copyWith(fontSize: 16),

                    // Max Line of Name is 1, if overflow then make it "Ravi Wimar..."
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),

        // Notification Button
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: neutral100),
            ),
            child: Image.asset(
              'assets/icons/notification_active.png',
              width: 24,
            ),
          ),
        ],
      ),

      // Body (based on Selected Pages)
      body: _pages[_currentIndex],

      // Add event button
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _currentIndex == 0 || _currentIndex == 1
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: primaryBase,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 32,
              ),
            )
          : null,

      // Bottom Nav Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryBase,
        unselectedItemColor: neutral400,
        selectedLabelStyle: regularTS.copyWith(fontSize: 12),
        unselectedLabelStyle: regularTS.copyWith(fontSize: 12),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Beranda',
            icon: ImageIcon(
              AssetImage('assets/icons/home.png'),
              size: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Kalender',
            icon: ImageIcon(
              AssetImage('assets/icons/calendar.png'),
              size: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Riwayat',
            icon: ImageIcon(
              AssetImage('assets/icons/history.png'),
              size: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profil',
            icon: ImageIcon(
              AssetImage('assets/icons/profile.png'),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
