import 'package:flutter/material.dart';
import 'package:face_count/features/riwayat/widgets/card_custom.dart';

class ListCard extends StatelessWidget {
  const ListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Container(
          height: 12,
        );
      },
      itemCount: 10,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const Padding(
            padding: EdgeInsets.only(top: 60),
            child: CardCustom(),
          );
        }
        return const CardCustom();
      },
    );
  }
}
