import 'package:flutter/material.dart';

class TabBarItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final String title;
  final double width;

  const TabBarItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.title,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border:
            Border.all(color: isSelected ? Colors.blue : Colors.grey, width: 1),
        color: isSelected ? Colors.blue : Colors.grey[100],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: (isSelected) ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}
