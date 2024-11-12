import 'package:cloud_firestore/cloud_firestore.dart';

class AcaraModel {
  final String? id_acara;
  final String? nama_acara;
  final String? desc_acara;
  final int? waktu_mulai, waktu_selesai;
  final DateTime? tanggal_acara;
  final String? tempat_acara;
  final int? jumlah_partisipan;

  AcaraModel({
    this.id_acara,
    this.nama_acara,
    this.desc_acara,
    this.waktu_mulai,
    this.waktu_selesai,
    this.tanggal_acara,
    this.tempat_acara,
    this.jumlah_partisipan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_acara': id_acara,
      'nama_acara': nama_acara,
      'desc_acara': desc_acara,
      'waktu_mulai': waktu_mulai,
      'waktu_selesai': waktu_selesai,
      'tanggal_acara': tanggal_acara,
      'tempat_acara': tempat_acara,
      'jumlah_partisipan': jumlah_partisipan
    };
  }

  factory AcaraModel.fromMap(Map<String, dynamic> map) {
    return AcaraModel(
      id_acara: map['id_acara'],
      nama_acara: map['nama_acara'],
      desc_acara: map['desc_acara'],
      waktu_mulai: map['waktu_mulai'],
      waktu_selesai: map['waktu_selesai'],
      tanggal_acara: (map['tanggal_acara'] as Timestamp).toDate(),
      tempat_acara: map['tempat_acara'],
      jumlah_partisipan: map['jumlah_partisipan'],
    );
  }

  AcaraModel copyWith({
    String? id_acara,
    String? nama_acara,
    String? desc_acara,
    int? waktu_mulai,
    int? waktu_selesai,
    DateTime? tanggal_acara,
    String? tempat_acara,
    int? jumlah_partisipan,
  }) =>
      AcaraModel(
        id_acara: id_acara ?? this.id_acara,
        nama_acara: nama_acara ?? this.nama_acara,
        desc_acara: desc_acara ?? this.desc_acara,
        waktu_mulai: waktu_mulai ?? this.waktu_mulai,
        waktu_selesai: waktu_selesai ?? this.waktu_selesai,
        tanggal_acara: tanggal_acara ?? this.tanggal_acara,
        tempat_acara: tempat_acara ?? this.tempat_acara,
        jumlah_partisipan: jumlah_partisipan ?? this.jumlah_partisipan,
      );
}
