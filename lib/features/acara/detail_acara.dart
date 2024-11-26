import 'package:face_count/features/acara/tambah_acara.dart';
import 'package:face_count/features/auth/cubit/acara_cubit.dart';
import 'package:face_count/features/auth/cubit/acara_state.dart';
import 'package:face_count/models/acara_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../configs/theme.dart';
// import 'package:face_count/features/acara/scan_pengunjung.dart';

class DetailAcara extends StatefulWidget {
  final AcaraModel acara;
  const DetailAcara({
    super.key,
    required this.acara,
  });

  @override
  State<DetailAcara> createState() => _DetailAcaraState();
}

class _DetailAcaraState extends State<DetailAcara> {
  final List<String> month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agt',
    'Sep',
    'Okt',
    'Nov',
    'Des'
  ];

  final List<String> day = [
    'Minggu',
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: neutral0),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: cardColor[widget.acara.rand_color],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                'assets/images/acara_card_flower.png',
                scale: 2,
              ),
            ),
          ),
          BlocBuilder<AcaraCubit, AcaraState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.only(top: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Title Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.acara.nama_acara.toString(),
                                  style: mediumTS.copyWith(
                                    fontSize: 24,
                                    color: neutral0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.acara.desc_acara.toString(),
                                  style: regularTS.copyWith(
                                    fontSize: 16,
                                    color: neutral300,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TambahAcara(
                                  isEditMode: true,
                                  acara: widget.acara,
                                ),
                              ));
                            },
                            child: Ink(
                              child: Row(
                                children: [
                                  ImageIcon(
                                    AssetImage(
                                      'assets/icons/edit.png',
                                    ),
                                    color: neutral0,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: () {
                              context
                                  .read<AcaraCubit>()
                                  .deleteAcara(widget.acara.id_acara!);
                              Navigator.of(context).pop();
                            },
                            child: ImageIcon(
                              AssetImage('assets/icons/delete.png'),
                              color: neutral0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // Event Details
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: neutral0,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Detail Acara',
                                style: regularTS.copyWith(
                                  fontSize: 18,
                                  color: neutral950,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                decoration: BoxDecoration(
                                  color: neutral50,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: neutral100,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                ),
                                child: Column(
                                  children: ListTile.divideTiles(
                                    context: context,
                                    color: neutral100,
                                    tiles: [
                                      ListTile(
                                        leading: const Icon(Icons.event),
                                        title: Text(
                                            '${day[widget.acara.tanggal_acara!.weekday % 7]}, ${widget.acara.tanggal_acara!.day} ${month[widget.acara.tanggal_acara!.month - 1]} ${widget.acara.tanggal_acara!.year}'),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.access_time),
                                        title: Text(
                                          '${widget.acara.waktu_mulai! < 10 ? '0' : ''}${widget.acara.waktu_mulai}.00 - '
                                          '${widget.acara.waktu_selesai! < 10 ? '0' : ''}${widget.acara.waktu_selesai}.00',
                                        ),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.place),
                                        title: Text(widget.acara.tempat_acara
                                            .toString()),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.people),
                                        title: Text(
                                            '${widget.acara.jumlah_partisipan} orang'),
                                      ),
                                    ],
                                  ).toList(),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text('Jumlah Pengunjung',
                                  style: regularTS.copyWith(
                                      fontSize: 18, color: Colors.black87)),
                              const SizedBox(height: 16),
                              Container(
                                decoration: BoxDecoration(
                                  color: neutral50,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: neutral100,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                ),
                                child: Column(
                                  children: ListTile.divideTiles(
                                    context: context,
                                    color: neutral100,
                                    tiles: [
                                      ListTile(
                                        leading: const Icon(Icons.male),
                                        title: const Text('70 orang'),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.female),
                                        title: const Text('30 orang'),
                                      ),
                                    ],
                                  ).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: neutral0,
        child: ElevatedButton.icon(
          onPressed: () async {
            await ImagePicker().pickImage(source: ImageSource.camera);
          },
          icon: const Icon(Icons.camera_alt, color: neutral0),
          label: Text(
            'Scan Pengunjung',
            style: regularTS.copyWith(color: neutral0),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBase,
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
      ),
    );
  }
}
