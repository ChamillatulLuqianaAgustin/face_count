import 'package:face_count/configs/theme.dart';
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: Text(
            'Riwayat',
            style: mediumTS.copyWith(
              fontSize: 20,
              color: neutral950,
            ),
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
          ],
        ),
      ),
    );
  }
}
