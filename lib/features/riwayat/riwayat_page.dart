import 'package:face_count/configs/theme.dart';
import 'package:face_count/features/auth/cubit/acara_cubit.dart';
import 'package:face_count/features/auth/cubit/acara_state.dart';
import 'package:face_count/features/riwayat/widgets/card_custom.dart';
import 'package:face_count/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_count/features/auth/cubit/acara_cubit.dart';
import 'package:face_count/features/riwayat/widgets/list_card.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  PageController pageController = PageController();
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<AcaraCubit>().fetchAcaraSelesai();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        surfaceTintColor: Colors.grey[100],
        title: Text(
          'Riwayat',
          style: mediumTS.copyWith(
            fontSize: 20,
            color: neutral950,
          ),
        ),
      ),
      body: BlocBuilder<AcaraCubit, AcaraState>(
        builder: (context, state) {
          if (state is AcaraLoading) {
            return Center(
              child: CircularProgressIndicator(),
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
                    )
                  ],
                ),
              );
            }
            // Urutkan berdasarkan tanggal (paling terbaru di atas)
            state.acaraList.sort((a, b) {
              final dateA = a.tanggalAcara ?? DateTime(0);
              final dateB = b.tanggalAcara ?? DateTime(0);
              return dateB.compareTo(dateA);
            });

            return ListView(
              children: state.acaraList.map((acara) {
                return CardCustom(
                  acaraModel: acara,
                  onPressed: () {},
                );
              }).toList(),
            );
          }
          return Container();
        },
      ),
      // body: Stack(
      //   children: [
      //     PageView(
      //       controller: pageController,
      //       physics: const NeverScrollableScrollPhysics(),
      //       onPageChanged: (value) => setState(() {
      //         selectedPage = value;
      //       }),
      //       children: const [
      //         ListCard(),
      //         Center(child: Text('2')),
      //         Center(child: Text('3')),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
