  import 'package:flutter/material.dart';

  import '../../../configs/theme.dart';

  class AcaraBerandaCard extends StatelessWidget {
    final Color leftColor;
    final Color rightColor;
    final String title;
    final String status;
    final String time;
    final String place;
    final VoidCallback? onPressed;

    const AcaraBerandaCard({
      super.key,
      required this.leftColor,
      required this.rightColor,
      required this.title,
      required this.status,
      required this.time,
      required this.place,
      this.onPressed
    });

    @override
    Widget build(BuildContext context) {
      return InkWell(onTap: onPressed, // Trigger the onPressed callback
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: [leftColor, rightColor],
          ),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: regularTS.copyWith(
                      fontSize: 24,
                      color: neutral0,
                    ),
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
                      status,
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
                        time,
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
                        place,
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
            const Spacer(),
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
