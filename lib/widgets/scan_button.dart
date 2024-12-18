import 'package:face_count/configs/theme.dart';
import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  final bool disabled;
  final VoidCallback? onTap;

  const ScanButton({
    Key? key,
    required this.disabled,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: disabled ? neutral500 : primaryBase,
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
    );
  }
}
