import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_count/configs/theme.dart';
import 'package:face_count/features/acara/detail_acara.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../acara/detail_acara.dart';

import '../auth/cubit/acara_cubit.dart';
import '../auth/cubit/acara_state.dart';
import 'widgets/acara_beranda_card.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  @override
  void initState() {
    context.read<AcaraCubit>().fetchAcara();
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
      body: BlocBuilder<AcaraCubit, AcaraState>(
        builder: (context, state) {
          if (state is AcaraLoaded) {
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
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Acara Hari Ini',
                  style: regularTS.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 8),
                ...state.acaraList.where((acara) {
                  final acaraDateTime = DateTime(
                    acara.tanggal_acara?.year ?? DateTime.now().year,
                    acara.tanggal_acara?.month ?? DateTime.now().month,
                    acara.tanggal_acara?.day ?? DateTime.now().day,
                    // acara.waktu_mulai ?? DateTime.now().hour,
                    // acara.waktu_selesai ?? DateTime.now().hour,
                  );
                  return acaraDateTime.isAfter(DateTime.now());
                }).map(
                  (acara) {
                    return AcaraBerandaCard(
                      acaraModel: acara,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailAcara(
                              acara: acara,
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            );
          }
          print('gagal ambil data');
          return Container();
        },
      ),
    );
  }
}
