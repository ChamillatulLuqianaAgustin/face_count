import 'package:flutter/material.dart';

import '../configs/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback? onTap;
  const CustomButton({
    super.key,
    required this.text,
    this.width = double.infinity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
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

class CustomLoadingButton extends StatelessWidget {
  const CustomLoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: primaryBase,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 23,
            width: 23,
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
