import 'dart:math';

import 'package:face_count/features/auth/cubit/acara_cubit.dart';
import 'package:face_count/features/auth/cubit/acara_state.dart';
import 'package:face_count/models/acara_model.dart';
import 'package:flutter/material.dart';
import 'package:face_count/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../configs/theme.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/dummy_textfield.dart';
// import '../model/acara.dart';

class TambahAcara extends StatefulWidget {
  final bool isEditMode;
  // final Acara acara;

  const TambahAcara({super.key, this.isEditMode = false});

  @override
  State<TambahAcara> createState() => _TambahAcaraState();
}

class _TambahAcaraState extends State<TambahAcara> {
  final _namaAcaraController = TextEditingController();
  final _descAcaraController = TextEditingController();
  final _tempatAcaraController = TextEditingController();
  final _jumlahPartisipanController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay _startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 0, minute: 0);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcaraCubit, AcaraState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AddAcaraSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const ImageIcon(AssetImage('assets/icons/arrow_back.png')),
              onPressed: () => Navigator.of(context).pop(),
            ),
            titleSpacing: 0,
            title: Text(
              widget.isEditMode ? 'Edit Acara' : 'Tambah Acara',
              style: mediumTS.copyWith(fontSize: 20),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _namaAcaraController,
                      label: 'Nama Acara',
                      hint: 'Masukkan nama acara',
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _descAcaraController,
                      label: 'Deskripsi Singkat',
                      hint: 'Masukkan deskripsi acara',
                    ),
                    const SizedBox(height: 16),
                    _buildTimePicker(),
                    const SizedBox(height: 16),
                    _buildDatePicker(),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _tempatAcaraController,
                      label: 'Tempat',
                      hint: 'Masukkan tempat',
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _jumlahPartisipanController,
                      keyboardType: TextInputType.number,
                      label: 'Jumlah Partisipan',
                      hint: 'Masukkan jumlah partisipan',
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            color: neutral0,
            child: state is AcaraLoading
                ? const CustomLoadingButton()
                : CustomButton(
                    text: widget.isEditMode ? 'Simpan' : 'Buat',
                    onTap: () => context.read<AcaraCubit>().addAcara(
                          acara: AcaraModel(
                            id_acara: generateUniqueIdAcara(10),
                            nama_acara: _namaAcaraController.text,
                            desc_acara: _descAcaraController.text,
                            waktu_mulai: _startTime.hour,
                            waktu_selesai: _endTime.hour,
                            tanggal_acara: _selectedDate,
                            tempat_acara: _tempatAcaraController.text,
                            jumlah_partisipan:
                                int.tryParse(_jumlahPartisipanController.text),
                            rand_color: Random().nextInt(3),
                          ),
                        ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Waktu',
          style: regularTS.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: DummyTextField(
                hint: _startTime.format(context),
                onTap: () => _selectTime(context, isStart: true),
                suffixIcon: const ImageIcon(
                  AssetImage('assets/icons/arrow_down.png'),
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '-',
              style: regularTS.copyWith(fontSize: 16),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DummyTextField(
                hint: _endTime.format(context),
                onTap: () => _selectTime(context, isStart: false),
                suffixIcon: const ImageIcon(
                  AssetImage('assets/icons/arrow_down.png'),
                  size: 24,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tanggal',
          style: regularTS.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 8),
        DummyTextField(
          hint: _selectedDate == null
              ? 'Masukkan tanggal'
              : '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}',
          onTap: () => _selectDate(context),
          suffixIcon: const ImageIcon(
            AssetImage('assets/icons/calendar_picker.png'),
            size: 24,
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime(
    BuildContext context, {
    required bool isStart,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => isStart ? _startTime = picked : _endTime = picked);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  String generateUniqueIdAcara(int length) {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();

    return List.generate(
            length, (index) => characters[random.nextInt(characters.length)])
        .join();
  }
}
