import 'package:flutter/material.dart';
import 'package:face_count/features/riwayat/widgets/tab_bar.dart';
import 'package:face_count/features/riwayat/widgets/tab_bar_item.dart';
import 'package:face_count/features/riwayat/widgets/list_card.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  PageController pageController = PageController();
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: const Text(
            'Riwayat',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        body: Stack(
          children: [
            PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) => setState(() {
                selectedPage = value;
              }),
              children: const [
                ListCard(),
                Center(child: Text('2')),
                Center(child: Text('3')),
              ],
            ),
            TopTabBar(
                items: [
                  TabBarItem(
                    index: 0,
                    isSelected: selectedPage == 0,
                    title: 'Hari ini',
                    width: 72,
                  ),
                  TabBarItem(
                    index: 1,
                    isSelected: selectedPage == 1,
                    title: 'Seminggu terakhir',
                    width: 128,
                  ),
                  TabBarItem(
                    index: 2,
                    isSelected: selectedPage == 2,
                    title: 'Sebulan terakhir',
                    width: 116,
                  ),
                ],
                onTap: (index) {
                  selectedPage = index;

                  pageController.animateToPage(selectedPage,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut);
                },
                selectedIndex: 0)
          ],
        ),
      ),
    );
  }
}
