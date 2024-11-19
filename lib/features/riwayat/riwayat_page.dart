import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_count/features/auth/cubit/acara_cubit.dart';
import 'package:face_count/features/riwayat/widgets/list_card.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  PageController pageController = PageController();
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<AcaraCubit>().fetchAcara();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: Text(
            'Riwayat',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        body: Stack(
          children: [
            PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) => setState(() {
                selectedPage = value;
              }),
              children: const [
                ListCard(),
                Center(child: Text('Tab 2')),
                Center(child: Text('Tab 3')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
