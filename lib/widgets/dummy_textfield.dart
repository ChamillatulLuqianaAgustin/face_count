import 'package:flutter/material.dart';

import '../configs/theme.dart';

class DummyTextField extends StatelessWidget {
  final String hint;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  const DummyTextField({
    super.key,
    required this.hint,
    this.onTap,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: neutral100),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hint,
                style: regularTS.copyWith(fontSize: 16),
              ),
            ),
            if (suffixIcon != null)
              Row(
                children: [
                  const SizedBox(width: 16),
                  suffixIcon!,
                ],
              ),
          ],
        ),
      ),
    );
  }
}
