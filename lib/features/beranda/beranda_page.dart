import 'package:face_count/configs/theme.dart';
import 'package:face_count/features/acara/detail_acara.dart';
import 'package:face_count/features/auth/cubit/picture_cubit.dart';
import 'package:face_count/utils/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../acara/detail_acara.dart';

import '../auth/cubit/acara_cubit.dart';
import '../auth/cubit/acara_state.dart';
import 'widgets/acara_beranda_card.dart';
import 'widgets/notif_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  @override
  void initState() {
    context.read<AcaraCubit>().fetchAcara();
    context.read<PictureCubit>().fetchPicture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

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
                    user!.displayName.toString(),
                    style: mediumTS.copyWith(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        // Notification Button
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //       Navigator.of(context).push(
        //         MaterialPageRoute(
        //           builder: (context) =>
        //               NotificationPage(), // Navigasi ke halaman Notifikasi
        //         ),
        //       );
        //     },
        //     child: Container(
        //       margin: const EdgeInsets.only(right: 8),
        //       padding: const EdgeInsets.all(10),
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         border: Border.all(color: neutral100),
        //       ),
        //       child: Image.asset(
        //         'assets/icons/notification_active.png',
        //         width: 24,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: BlocBuilder<AcaraCubit, AcaraState>(
        builder: (context, state) {
          if (state is AcaraLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AcaraLoaded) {
            if (state.acaraList.isEmpty) {
              return Center(
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
              );
            }

            // Filter acara hari ini
            final acaraHariIni = state.acaraList
                .where((acara) =>
                    acara.tanggalAcara != null &&
                    isSameDay(acara.tanggalAcara!, DateTime.now()) &&
                    acara.waktuSelesai!.isAfter(
                        DateTime.now())) // Check if acara ends after now
                .toList();

            // Filter dan urutkan acara akan datang
            final acaraAkanDatang = state.acaraList
                .where((acara) =>
                    acara.tanggalAcara != null &&
                    acara.tanggalAcara!.isAfter(DateTime.now()) &&
                    !isSameDay(acara.tanggalAcara!,
                        DateTime.now())) // Check if acara date is after now
                .toList()
              ..sort((a, b) => a.tanggalAcara!
                  .compareTo(b.tanggalAcara!)); // Sort by tanggalAcara

            // Ambil maksimal 5 acara terdekat
            final acaraTerbatas = acaraAkanDatang.take(5).toList();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Acara Hari Ini
                if (acaraHariIni.isNotEmpty) ...[
                  Text(
                    'Acara Hari Ini',
                    style: regularTS.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  ...acaraHariIni.map(
                    (acara) {
                      return AcaraBerandaCard(
                        acaraModel: acara,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailAcara(acara: acara),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],

                // Acara Akan Datang
                if (acaraTerbatas.isNotEmpty) ...[
                  Text(
                    'Acara Akan Datang',
                    style: regularTS.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  ...acaraTerbatas.map(
                    (acara) {
                      return AcaraBerandaCard(
                        acaraModel: acara,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailAcara(acara: acara),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
