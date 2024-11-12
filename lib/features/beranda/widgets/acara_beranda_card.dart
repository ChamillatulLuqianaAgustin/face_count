import 'package:flutter/material.dart';

import '../../../configs/theme.dart';
import '../../../models/acara_model.dart';

class AcaraBerandaCard extends StatelessWidget {
  final AcaraModel acaraModel;
  final VoidCallback? onPressed;

  AcaraBerandaCard({
    super.key,
    required this.acaraModel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Trigger the onPressed callback
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: cardColor[acaraModel.rand_color],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      acaraModel.nama_acara.toString(),
                      style: regularTS.copyWith(
                        fontSize: 24,
                        color: neutral0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: neutral100),
                      ),
                      child: Text(
                        (acaraModel.tanggal_acara ?? DateTime.now())
                                .isAfter(DateTime.now())
                            ? 'Akan Datang'
                            : 'Selesai',
                        style: regularTS.copyWith(
                          fontSize: 10,
                          color: neutral100,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const ImageIcon(
                          AssetImage('assets/icons/time.png'),
                          size: 16,
                          color: neutral100,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${acaraModel.waktu_mulai! < 10 ? '0' : ''}${acaraModel.waktu_mulai}.00 - '
                          '${acaraModel.waktu_selesai! < 10 ? '0' : ''}${acaraModel.waktu_selesai}.00',
                          style: regularTS.copyWith(
                            fontSize: 12,
                            color: neutral100,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const ImageIcon(
                          AssetImage('assets/icons/place.png'),
                          size: 16,
                          color: neutral100,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          acaraModel.tempat_acara.toString(),
                          style: regularTS.copyWith(
                            fontSize: 12,
                            color: neutral100,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Image.asset(
              'assets/images/acara_card_flower.png',
              scale: 2,
            )
          ],
        ),
      ),
    );
  }
}
