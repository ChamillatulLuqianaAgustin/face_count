import 'dart:math';
import 'package:face_count/features/acara/cubit/acara/acara_cubit.dart';
import 'package:face_count/features/acara/cubit/acara/acara_state.dart';
import 'package:face_count/models/acara_model.dart';
import 'package:face_count/utils/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:face_count/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../configs/theme.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/dummy_textfield.dart';

class TambahAcara extends StatefulWidget {
  final bool isEditMode;
  final AcaraModel? acara;

  const TambahAcara({super.key, this.isEditMode = false, this.acara});

  @override
  State<TambahAcara> createState() => _TambahAcaraState();
}

class _TambahAcaraState extends State<TambahAcara> {
  final user = FirebaseAuth.instance.currentUser;
  final _namaAcaraController = TextEditingController();
  final _descAcaraController = TextEditingController();
  final _tempatAcaraController = TextEditingController();
  final _jumlahPartisipanController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay _startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 0, minute: 0);

  @override
  void initState() {
    super.initState();
    if (widget.isEditMode && widget.acara != null) {
      _namaAcaraController.text = widget.acara?.namaAcara ?? '';
      _descAcaraController.text = widget.acara?.descAcara ?? '';
      _tempatAcaraController.text = widget.acara?.tempatAcara ?? '';
      _jumlahPartisipanController.text =
          widget.acara?.jumlahPartisipan?.toString() ?? '';
      _selectedDate = widget.acara?.tanggalAcara;
      _startTime = TimeOfDay(
        hour: (widget.acara?.waktuMulai ?? DateTime.now()).hour,
        minute: (widget.acara?.waktuMulai ?? DateTime.now()).minute,
      );
      _endTime = TimeOfDay(
        hour: (widget.acara?.waktuSelesai ?? DateTime.now()).hour,
        minute: (widget.acara?.waktuSelesai ?? DateTime.now()).minute,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcaraCubit, AcaraState>(
      listener: (context, state) {
        if (state is AddAcaraSuccess) {
          Navigator.of(context).pop();
        } else if (state is UpdateAcaraSuccess) {
          Navigator.of(context).pop();
        } else if (state is AcaraError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
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
                      hint: widget.isEditMode
                          ? widget.acara!.namaAcara.toString()
                          : 'Masukkan nama acara',
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _descAcaraController,
                      label: 'Deskripsi Singkat',
                      hint: widget.isEditMode
                          ? widget.acara!.descAcara.toString()
                          : 'Masukkan deskripsi acara',
                    ),
                    const SizedBox(height: 16),
                    _buildTimePicker(),
                    const SizedBox(height: 16),
                    _buildDatePicker(),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _tempatAcaraController,
                      label: 'Tempat',
                      hint: widget.isEditMode
                          ? widget.acara!.tempatAcara.toString()
                          : 'Masukkan tempat',
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _jumlahPartisipanController,
                      keyboardType: TextInputType.number,
                      label: 'Jumlah Partisipan',
                      hint: widget.isEditMode
                          ? widget.acara!.jumlahPartisipan.toString()
                          : 'Masukkan jumlah partisipan',
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
                    onTap: () {
                      if (widget.isEditMode) {
                        context.read<AcaraCubit>().updateAcara(
                              AcaraModel(
                                idAcara: widget.acara!.idAcara,
                                namaAcara: _namaAcaraController.text,
                                descAcara: _descAcaraController.text,
                                waktuMulai: DateTime(
                                  _selectedDate!.year,
                                  _selectedDate!.month,
                                  _selectedDate!.day,
                                  _startTime.hour,
                                  _startTime.minute,
                                ),
                                waktuSelesai: DateTime(
                                  _selectedDate!.year,
                                  _selectedDate!.month,
                                  _selectedDate!.day,
                                  _endTime.hour,
                                  _endTime.minute,
                                ),
                                tanggalAcara: _selectedDate,
                                tempatAcara: _tempatAcaraController.text,
                                jumlahPartisipan: int.tryParse(
                                    _jumlahPartisipanController.text),
                                randColor: widget.acara!.randColor,
                              ),
                            );
                      } else {
                        context.read<AcaraCubit>().addAcara(
                              acara: AcaraModel(
                                uid: user!.uid,
                                idAcara: generateUniqueIdAcara(10),
                                namaAcara: _namaAcaraController.text,
                                descAcara: _descAcaraController.text,
                                waktuMulai: DateTime(
                                  _selectedDate!.year,
                                  _selectedDate!.month,
                                  _selectedDate!.day,
                                  _startTime.hour,
                                  _startTime.minute,
                                ),
                                waktuSelesai: DateTime(
                                  _selectedDate!.year,
                                  _selectedDate!.month,
                                  _selectedDate!.day,
                                  _endTime.hour,
                                  _endTime.minute,
                                ),
                                tanggalAcara: _selectedDate,
                                tempatAcara: _tempatAcaraController.text,
                                jumlahPartisipan: int.tryParse(
                                    _jumlahPartisipanController.text),
                                randColor: Random().nextInt(cardColor.length),
                              ),
                            );
                      }
                    },
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
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
