import 'dart:convert';

import 'package:face_count/features/acara/models/result_page.dart';
import 'package:face_count/features/acara/tambah_acara.dart';
import 'package:face_count/features/auth/cubit/acara_cubit.dart';
import 'package:face_count/features/auth/cubit/acara_state.dart';
import 'package:face_count/models/acara_model.dart';
import 'package:face_count/utils/methods.dart';
import 'package:face_count/widgets/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../configs/theme.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

// import 'package:face_count/features/acara/scan_pengunjung.dart';

class DetailAcara extends StatefulWidget {
  final AcaraModel acara;
  const DetailAcara({super.key, required this.acara});

  @override
  State<DetailAcara> createState() => _DetailAcaraState();
}

class _DetailAcaraState extends State<DetailAcara> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
      sendImages(selectedImages, context);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }

  Future<void> sendImages(List<XFile> imageFiles, BuildContext context) async {
    final uri = Uri.parse('http://172.24.161.222:5000/predict');

    var request = http.MultipartRequest('POST', uri);

    try {
      // Tambahkan setiap gambar ke request
      for (var image in imageFiles) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'images', // Key yang sesuai dengan backend
            image.path,
          ),
        );
      }

      // Kirim request
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final decodedResponse = jsonDecode(responseData.body);

        // Data dari backend
        int maleCount = decodedResponse['male'];
        int femaleCount = decodedResponse['female'];
        List<String> processedImageUrls =
            List<String>.from(decodedResponse['processed_images']);

        // Navigasi ke ResultPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              imageUrls: processedImageUrls,
              maleCount: maleCount,
              femaleCount: femaleCount,
            ),
          ),
        );
      } else {
        print('Failed to predict. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while sending images: $e');
    }
  }

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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Konfirmasi hapus',
                                            style:
                                                mediumTS.copyWith(fontSize: 18),
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
                                                        .deleteAcara(widget
                                                            .acara.idAcara!);
                                                    // Tutup dialog
                                                    Navigator.of(context).pop();
                                                    // Kembali ke halaman sebelumnya
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 12,
                                                      vertical: 12,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: primaryBase,
                                                      border: Border.all(
                                                          color: primaryBase,
                                                          width: 1.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: Text(
                                                      'Hapus',
                                                      style: mediumTS.copyWith(
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 12,
                                                      vertical: 12,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: neutral950,
                                                          width: 1.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: Text(
                                                      'Batal',
                                                      style: mediumTS.copyWith(
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
                                          title: Text(formatToIndonesianDate(
                                              widget.acara.tanggalAcara ??
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
                                          title: Text(widget.acara.tempatAcara
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
        // bottomNavigationBar: Container(
        //   padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        //   color: neutral0,
        //   child: GestureDetector(
        //     onTap: () async {
        //       await ImagePicker().pickImage(source: ImageSource.camera);
        //     },
        //     // icon: const Icon(Icons.camera_alt, color: neutral0),
        //     // label: Text(
        //     //   'Scan Pengunjung',
        //     //   style: mediumTS.copyWith(color: neutral0),
        //     // ),
        //     // style: ElevatedButton.styleFrom(
        //     //   backgroundColor: primaryBase,
        //     //   minimumSize: const Size(double.infinity, 48),
        //     // ),

        //   ),
        // ),
        bottomNavigationBar:
            // (isSameDay(widget.acara.tanggalAcara!, DateTime.now()) &&
            //         widget.acara.waktuSelesai!.isAfter(DateTime.now()))
            /*?*/ Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          color: neutral0,
          child: GestureDetector(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => CameraScreen()));
              selectImages();
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: primaryBase,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/media.png',
                    color: neutral0,
                    width: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Scan Pengunjung',
                    style: mediumTS.copyWith(
                      color: neutral0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        // : null,
        );
  }
}
