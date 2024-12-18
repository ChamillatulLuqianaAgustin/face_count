import 'package:flutter/material.dart';

import '../configs/theme.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final Widget? icon;
  final String text;
  final bool disabled;
  final VoidCallback? onTap;
  const CustomButton({
    super.key,
    this.icon,
    this.backgroundColor = primaryBase,
    required this.text,
    this.disabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !disabled ? onTap : null,
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: !disabled ? backgroundColor : neutral500,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: mediumTS.copyWith(
                  fontSize: 16,
                  color: backgroundColor == neutral0 ? neutral100 : neutral0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
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
            child: CircularProgressIndicator(color: neutral0),
          ),
        ],
      ),
    );
  }
}
