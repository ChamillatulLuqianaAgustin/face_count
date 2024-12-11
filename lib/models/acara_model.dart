import 'package:cloud_firestore/cloud_firestore.dart';

class AcaraModel {
  final String? uid;
  final String? idAcara;
  final String? namaAcara;
  final String? descAcara;
  final DateTime? tanggalAcara;
  final DateTime? waktuMulai, waktuSelesai;
  final String? tempatAcara;
  final int? jumlahPartisipan;
  final int randColor;

  AcaraModel({
    this.uid,
    this.idAcara,
    this.namaAcara,
    this.descAcara,
    this.tanggalAcara,
    this.waktuMulai,
    this.waktuSelesai,
    this.tempatAcara,
    this.jumlahPartisipan,
    required this.randColor,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id_acara': idAcara,
      'nama_acara': namaAcara,
      'desc_acara': descAcara,
      'waktu_mulai': waktuMulai,
      'waktu_selesai': waktuSelesai,
      'tempat_acara': tempatAcara,
      'jumlah_partisipan': jumlahPartisipan,
      'rand_color': randColor,
    };
  }

  factory AcaraModel.fromMap(Map<String, dynamic> map) {
    return AcaraModel(
      uid: map['uid'],
      idAcara: map['id_acara'],
      namaAcara: map['nama_acara'],
      descAcara: map['desc_acara'],
      waktuMulai: (map['waktu_mulai'] as Timestamp).toDate(),
      waktuSelesai: (map['waktu_selesai'] as Timestamp).toDate(),
      tanggalAcara: (map['waktu_mulai'] as Timestamp).toDate(),
      tempatAcara: map['tempat_acara'],
      jumlahPartisipan: map['jumlah_partisipan'],
      randColor: map['rand_color'],
    );
  }

  get status => null;

  AcaraModel copyWith({
    String? idAcara,
    String? namaAcara,
    String? descAcara,
    DateTime? tanggalAcara,
    DateTime? waktuMulai,
    DateTime? waktuSelesai,
    String? tempatAcara,
    int? jumlahPartisipan,
    int? randColor,
  }) {
    return AcaraModel(
      idAcara: idAcara ?? this.idAcara,
      namaAcara: namaAcara ?? this.namaAcara,
      descAcara: descAcara ?? this.descAcara,
      waktuMulai: waktuMulai ?? this.waktuMulai,
      waktuSelesai: waktuSelesai ?? this.waktuSelesai,
      tanggalAcara: tanggalAcara ?? this.tanggalAcara,
      tempatAcara: tempatAcara ?? this.tempatAcara,
      jumlahPartisipan: jumlahPartisipan ?? this.jumlahPartisipan,
      randColor: randColor ?? this.randColor,
    );
  }
}
