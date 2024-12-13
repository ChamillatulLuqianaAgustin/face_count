import 'package:face_count/features/acara/cubit/acara/acara_cubit.dart';
import 'package:face_count/features/acara/cubit/acara/acara_state.dart';
import 'package:face_count/features/riwayat/widgets/card_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_count/features/acara/detail_acara.dart';
import 'package:face_count/configs/theme.dart';

class ListCard extends StatelessWidget {
  const ListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AcaraCubit, AcaraState>(
      builder: (context, state) {
        if (state is AcaraLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AcaraError) {
          return Center(
            child: Text(
              'Gagal memuat data acara',
              style: mediumTS.copyWith(fontSize: 16, color: Colors.red),
            ),
          );
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
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemCount: state.acaraList.length,
            itemBuilder: (context, index) {
              final acara = state.acaraList[index];

              return CardCustom(
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
          );
        }

        return const Center(
          child: Text('Tidak ada data untuk ditampilkan'),
        );
      },
    );
  }
}
