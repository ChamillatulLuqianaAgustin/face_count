import 'package:face_count/features/acara/cubit/acara/acara_cubit.dart';
import 'package:face_count/features/acara/cubit/acara/acara_state.dart';
import 'package:face_count/features/acara/cubit/picture/picture_cubit.dart';
import 'package:face_count/features/acara/cubit/picture/picture_state.dart';
import 'package:face_count/features/acara/result_scan.dart';
import 'package:face_count/features/acara/tambah_acara.dart';
import 'package:face_count/models/acara_model.dart';
import 'package:face_count/utils/methods.dart';
import 'package:face_count/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_image_camera/camera_file.dart';
import 'package:multiple_image_camera/multiple_image_camera.dart';
import '../../configs/theme.dart';
// import 'package:http/http.dart' as http;

// import 'package:face_count/features/acara/scan_pengunjung.dart';

class DetailAcara extends StatefulWidget {
  final AcaraModel acara;
  const DetailAcara({super.key, required this.acara});

  @override
  State<DetailAcara> createState() => _DetailAcaraState();
}

class _DetailAcaraState extends State<DetailAcara> {
  final user = FirebaseAuth.instance.currentUser;
  List<MediaModel> imageList = [];

  @override
  Widget build(BuildContext context) {
    bool acaraBelumMulai =
        isSameDay(widget.acara.tanggalAcara!, DateTime.now()) &&
            widget.acara.waktuSelesai!.isAfter(DateTime.now());

    return BlocProvider(
      create: (context) => PictureCubit(),
      child: BlocConsumer<PictureCubit, PictureState>(
        listener: (context, state) {
          if (state is PictureLoading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryBase),
                      ),
                      const SizedBox(height: 20),
                      Text('Mengunggah Hasil Scan',
                          style: mediumTS.copyWith(
                            fontSize: 16,
                            color: neutral950,
                          )),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is PictureAddSuccess) {
            Navigator.of(context).pop(); // Close loading

            setState(() {
              widget.acara.male = (widget.acara.male ?? 0) + state.male;
              widget.acara.female = (widget.acara.female ?? 0) + state.female;
            });

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ScanResultPage(
                  idAcara: widget.acara.idAcara.toString(),
                  male: widget.acara.male ?? 0,
                  female: widget.acara.female ?? 0,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const ImageIcon(
                  AssetImage('assets/icons/arrow_back.png'),
                  color: neutral0,
                ),
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
                      colors: cardColor[widget.acara.randColor],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.acara.namaAcara.toString(),
                                        style: mediumTS.copyWith(
                                          fontSize: 24,
                                          color: neutral0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        widget.acara.descAcara.toString(),
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
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
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
                                  onTap: () => showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        alignment: Alignment.center,
                                        contentPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        content: Container(
                                          width: double.infinity,
                                          height: 170,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: neutral0,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Konfirmasi hapus',
                                                style: mediumTS.copyWith(
                                                    fontSize: 18),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Anda yakin ingin menghapus acara ini? Tindakan ini tidak dapat dibatalkan.',
                                                style: regularTS.copyWith(
                                                  fontSize: 14,
                                                  color: neutral400,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        // Lakukan penghapusan
                                                        await context
                                                            .read<AcaraCubit>()
                                                            .deleteAcara(
                                                                widget.acara
                                                                    .idAcara!,
                                                                user!.uid);
                                                        // Tutup dialog
                                                        Navigator.of(context)
                                                            .pop();
                                                        // Kembali ke halaman sebelumnya
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 12,
                                                          vertical: 12,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: primaryBase,
                                                          border: Border.all(
                                                              color:
                                                                  primaryBase,
                                                              width: 1.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                        child: Text(
                                                          'Hapus',
                                                          style:
                                                              mediumTS.copyWith(
                                                            fontSize: 16,
                                                            color: neutral0,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(
                                                            context); // Tutup dialog tanpa aksi
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 12,
                                                          vertical: 12,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: neutral950,
                                                              width: 1.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                        child: Text(
                                                          'Batal',
                                                          style:
                                                              mediumTS.copyWith(
                                                            fontSize: 16,
                                                            color: neutral950,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
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
                                      style: mediumTS.copyWith(
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
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside,
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
                                                  formatToIndonesianDate(widget
                                                          .acara.tanggalAcara ??
                                                      DateTime.now())),
                                            ),
                                            ListTile(
                                              leading:
                                                  const Icon(Icons.access_time),
                                              title: Text(
                                                '${formatTo24Hour(widget.acara.waktuMulai ?? DateTime.now())} - '
                                                '${formatTo24Hour(widget.acara.waktuSelesai ?? DateTime.now())}',
                                              ),
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.place),
                                              title: Text(widget
                                                  .acara.tempatAcara
                                                  .toString()),
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.people),
                                              title: Text(
                                                  '${widget.acara.jumlahPartisipan} orang'),
                                            ),
                                          ],
                                        ).toList(),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Ringkasan',
                                          style: mediumTS.copyWith(
                                            fontSize: 18,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ScanResultPage(
                                                  idAcara: widget.acara.idAcara
                                                      .toString(),
                                                  male: widget.acara.male ?? 0,
                                                  female:
                                                      widget.acara.female ?? 0,
                                                ), // Replace with your actual screen
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Lihat Hasil Scan',
                                            style: regularTS.copyWith(
                                              fontSize: 14,
                                              color: primaryBase,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: neutral50,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: neutral100,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside,
                                        ),
                                      ),
                                      child: Column(
                                        children: ListTile.divideTiles(
                                          context: context,
                                          color: neutral100,
                                          tiles: [
                                            ListTile(
                                              leading: const Icon(Icons.male),
                                              title: Text(
                                                  '${widget.acara.male ?? 0} orang'),
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.female),
                                              title: Text(
                                                  '${widget.acara.female ?? 0} orang'),
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              color: neutral0,
              child: CustomButton(
                text: 'Scan Pengunjung',
                icon: ImageIcon(
                  AssetImage('assets/icons/camera.png'),
                  color: neutral0,
                ),
                disabled: !acaraBelumMulai || state is PictureLoading,
                onTap: () async {
                  final images =
                      await MultipleImageCamera.capture(context: context);

                  if (images.isNotEmpty) {
                    setState(() => imageList = images);
                    context
                        .read<PictureCubit>()
                        .sendImages(
                          idAcara: widget.acara.idAcara.toString(),
                          images: imageList,
                        )
                        .then((_) {
                      // Menutup dialog
                      Navigator.of(context).pop();
                    }).catchError((_) {
                      // Menutup dialog jika ada error
                      Navigator.of(context).pop();
                    });
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
