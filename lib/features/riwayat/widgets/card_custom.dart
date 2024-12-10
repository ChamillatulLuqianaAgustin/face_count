import 'package:face_count/configs/theme.dart';
import 'package:face_count/features/acara/detail_acara.dart';
import 'package:face_count/utils/methods.dart';
import 'package:flutter/material.dart';

import '../../../models/acara_model.dart';

class CardCustom extends StatelessWidget {
  final AcaraModel acaraModel;
  const CardCustom({
    super.key,
    required this.acaraModel,
    required VoidCallback? onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        acaraModel.namaAcara.toString(),
                        style: mediumTS.copyWith(
                          fontSize: 16,
                          color: neutral950,
                        ),
                      ),
                      Text(
                        acaraModel.descAcara.toString(),
                        style: regularTS.copyWith(
                          color: neutral400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
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
          const Divider(
            color: neutral50,
            height: 12,
          ),
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
                        formatDate(acaraModel.tanggalAcara ?? DateTime.now()),
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
                        '${formatTo24Hour(acaraModel.waktuMulai ?? DateTime.now())} - ${formatTo24Hour(acaraModel.waktuSelesai ?? DateTime.now())}',
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
                        'Tempat',
                        style: regularTS.copyWith(
                          color: neutral400,
                        ),
                      ),
                      Text(
                        acaraModel.tempatAcara.toString(),
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
                        '${acaraModel.jumlahPartisipan} orang',
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
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailAcara(acara: acaraModel),
                  ),
                );
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.black),
                  ),
                  child: FittedBox(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Detail',
                        style: mediumTS.copyWith(fontSize: 16),
                      ),
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
