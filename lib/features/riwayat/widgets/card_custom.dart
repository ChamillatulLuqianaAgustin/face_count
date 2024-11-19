import 'package:face_count/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../models/acara_model.dart';

class CardCustom extends StatelessWidget {
  final AcaraModel acaraModel;
  final VoidCallback? onPressed;

  CardCustom({
    super.key,
    required this.acaraModel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? tanggalAcara = acaraModel.tanggal_acara;
    String hari = '';
    String tanggal = '';

    if (tanggalAcara != null) {
      hari = DateFormat('EEEE', 'id_ID')
          .format(tanggalAcara); // Nama hari dalam Bahasa Indonesia
      tanggal = DateFormat('dd MMMM yyyy', 'id_ID')
          .format(tanggalAcara); // Format tanggal
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: neutral0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      acaraModel.nama_acara.toString(),
                      style: mediumTS.copyWith(
                        fontSize: 16,
                        color: neutral950,
                      ),
                    ),
                    Text(
                      acaraModel.desc_acara.toString(),
                      style: regularTS.copyWith(
                        color: neutral300,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: primary100,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Selesai',
                      style: regularTS.copyWith(
                        color: primaryBase,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const Divider(),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hari',
                        style: regularTS.copyWith(
                          color: neutral400,
                        ),
                      ),
                      Text(
                        '$hari, $tanggal',
                        style: regularTS.copyWith(
                          fontSize: 16,
                          color: neutral950,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width / 2 - 64,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Waktu',
                        style: regularTS.copyWith(
                          color: neutral400,
                        ),
                      ),
                      Text(
                        '${acaraModel.waktu_mulai! < 10 ? '0' : ''}${acaraModel.waktu_mulai}.00 - '
                        '${acaraModel.waktu_selesai! < 10 ? '0' : ''}${acaraModel.waktu_selesai}.00',
                        style: regularTS.copyWith(
                          fontSize: 16,
                          color: neutral950,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        acaraModel.tempat_acara.toString(),
                        style: regularTS.copyWith(
                          color: neutral400,
                        ),
                      ),
                      Text(
                        acaraModel.tempat_acara.toString(),
                        style: regularTS.copyWith(
                          fontSize: 16,
                          color: neutral950,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width / 2 - 64,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Peserta',
                        style: regularTS.copyWith(
                          color: neutral400,
                        ),
                      ),
                      Text(
                        acaraModel.jumlah_partisipan.toString(),
                        style: regularTS.copyWith(
                          fontSize: 16,
                          color: neutral950,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: onPressed,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 60,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Detail',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
