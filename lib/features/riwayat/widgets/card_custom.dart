import 'package:flutter/material.dart';

class CardCustom extends StatelessWidget {
  const CardCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Seminar Nasional',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text('Tips Belajar Machine Learning'),
                  ],
                ),
                Container(
                  width: 60,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Selesai',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const Divider(),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hari'),
                      Text(
                        'Selasa, 25 Sep 2023',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 64,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Waktu'),
                      Text(
                        '06.00 - 10.00',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tempat'),
                      Text(
                        'Auditorium lt. 8',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 64,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Peserta'),
                      Text(
                        '100 orang',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: () {},
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 60,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Detail',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
