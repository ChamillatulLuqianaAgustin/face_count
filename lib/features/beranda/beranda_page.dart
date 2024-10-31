import 'package:face_count/configs/theme.dart';
import 'package:face_count/features/acara/detail_acara.dart';
import 'package:flutter/material.dart';
// import '../acara/detail_acara.dart';

import 'widgets/acara_beranda_card.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isEventEmpty = false;

    return Scaffold(
      // Appbar
      appBar: AppBar(
        toolbarHeight: 80,
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
      body: isEventEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/no_event.png'),
                  Text(
                    'Belum ada event yang tercatat.',
                    style: mediumTS.copyWith(fontSize: 20),
                  ),
                  const Text(
                    'Tambahkan event pertama kamu sekarang!',
                    style: regularTS,
                  )
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Acara Hari Ini',
                  style: regularTS.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 8),
                AcaraBerandaCard(
                  leftColor: purple950,
                  rightColor: purpleBase,
                  title: 'Seminar Nasional',
                  status: 'Berlangsung',
                  time: '08.00 - 12.00',
                  place: 'Auditorium Lt. 8',
                  onPressed : (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const DetailAcara(),)
                    );
                  },
                ),
                const SizedBox(height: 8),
                AcaraBerandaCard(
                  leftColor: red950,
                  rightColor: redBase,
                  title: 'Kuliah Tamu',
                  status: 'Berlangsung',
                  time: '08.00 - 12.00',
                  place: 'Auditorium Lt. 8',
                ),
                const SizedBox(height: 8),
                AcaraBerandaCard(
                  leftColor: primary950,
                  rightColor: primaryBase,
                  title: 'Workshop',
                  status: 'Berlangsung',
                  time: '08.00 - 12.00',
                  place: 'Auditorium Lt. 8',
                ),
              ],
            ),
    );
  }
  
}