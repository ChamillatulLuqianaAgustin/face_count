import 'package:flutter/material.dart';

import '../configs/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: primaryBase,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          text,
          style: mediumTS.copyWith(fontSize: 16, color: neutral0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
