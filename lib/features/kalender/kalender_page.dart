import 'package:face_count/configs/theme.dart';
import 'package:face_count/features/acara/detail_acara.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:face_count/features/auth/cubit/acara_cubit.dart';
import 'package:face_count/features/auth/cubit/acara_state.dart';

import '../beranda/widgets/acara_beranda_card.dart';
import 'detail_acara_page.dart';

class KalenderPage extends StatefulWidget {
  const KalenderPage({super.key});

  @override
  State<KalenderPage> createState() => _KalenderPageState();
}

class _KalenderPageState extends State<KalenderPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchEventsForSelectedDate();
  }

  void _fetchEventsForSelectedDate() {
    context.read<AcaraCubit>().getAcaraByDate(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        surfaceTintColor: Colors.grey[100],
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${DateFormat('MMMM').format(_selectedDate)} ${_selectedDate.year}', // Display month name
              style: mediumTS.copyWith(fontSize: 20),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Image.asset(
                'assets/icons/calendar_picker.png',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                final date = _selectedDate
                    .add(Duration(days: index - _selectedDate.weekday));
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = date;
                      _fetchEventsForSelectedDate();
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        [
                          'SUN',
                          'MON',
                          'TUE',
                          'WED',
                          'THU',
                          'FRI',
                          'SAT'
                        ][date.weekday % 7],
                        style: regularTS.copyWith(fontSize: 12),
                      ),
                      Text(
                        '${date.day}',
                        style: mediumTS.copyWith(fontSize: 16),
                      ),
                      if (_selectedDate.day == date.day &&
                          _selectedDate.month == date.month &&
                          _selectedDate.year == date.year)
                        Container(
                          height: 2,
                          width: 20,
                          color: Colors.black,
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<AcaraCubit, AcaraState>(
              builder: (context, state) {
                if (state is AcaraLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AcaraLoaded) {
                  final acaraList = state.acaraList;
                  if (acaraList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/no_event.png'),
                          Text(
                            'Belum ada event yang tercatat.',
                            style: mediumTS.copyWith(fontSize: 20),
                          ),
                          const Text(
                            'Tambahkan event pertama kamu sekarang!',
                            style: regularTS,
                          )
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: acaraList.length,
                      itemBuilder: (context, index) {
                        final acara = acaraList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailAcaraPage(
                                  title: acara.nama_acara ?? '',
                                  subtitle: acara.desc_acara ?? '',
                                  date: DateFormat('EEEE, d MMM yyyy').format(
                                      acara.tanggal_acara ?? DateTime.now()),
                                  time:
                                      '${acara.waktu_mulai} - ${acara.waktu_selesai}',
                                  place: acara.tempat_acara ?? '',
                                  attendees: '${acara.jumlah_partisipan} orang',
                                ),
                              ),
                            );
                          },
                          child: AcaraBerandaCard(
                            acaraModel: acara,
                          ),
                        );
                      },
                    );
                  }
                } else if (state is AcaraError) {
                  return Center(
                      child: Text('Failed to load events: ${state.message}'));
                }
                return Center(child: Text('No events'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _fetchEventsForSelectedDate();
      });
    }
  }
}
