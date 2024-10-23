import 'package:flutter/material.dart';
import 'package:face_count/features/riwayat/widgets/tab_bar_item.dart';

class TopTabBar extends StatelessWidget {
  final List<TabBarItem> items;
  final void Function(int index) onTap;
  final int selectedIndex;

  const TopTabBar(
      {super.key,
      required this.items,
      required this.onTap,
      required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items
              .map((e) => GestureDetector(
                    onTap: () => onTap(e.index),
                    child: e,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
