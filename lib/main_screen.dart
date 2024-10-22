import 'package:face_count/configs/theme.dart';
import 'package:flutter/material.dart';

import 'features/acara/tambah_acara.dart';
import 'features/beranda/beranda_page.dart';
import 'features/kalender/kalender_page.dart';
// import 'features/profil/profil_page.dart';
import 'features/riwayat/riwayat_page.dart';
import 'features/login/login_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List of Navbar Pages
  final List<Widget> _pages = [
    const BerandaPage(),
    const KalenderPage(),
    const RiwayatPage(),
    const LoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body (based on Selected Pages)
      body: _pages[_currentIndex],

      // Add event button
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _currentIndex == 0 || _currentIndex == 1
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TambahAcara())),
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
