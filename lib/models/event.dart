import 'package:equatable/equatable.dart';

class Event extends Equatable {
  const Event({
    required this.id,
    required this.idCabor,
    required this.namaEvent,
    required this.gambar,
    required this.tanggalStart,
    required this.tanggalEnd,
    required this.expReg,
    required this.status,
  });

  final String id;
  final String idCabor;
  final String namaEvent;
  final String gambar;
  final DateTime tanggalStart;
  final DateTime tanggalEnd;
  final DateTime expReg;
  final String status;

  static DateTime _convertToDateTime(String date) {
    return DateTime.parse(date);
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
        id: map['id'],
        idCabor: map['id_cabor'],
        namaEvent: map['nama_event'],
        gambar: map['gambar'],
        tanggalStart: _convertToDateTime(map['tanggal_start']),
        tanggalEnd: _convertToDateTime(map['tanggal_end']),
        expReg: _convertToDateTime(map['exp_reg']),
        status: map['status']);
  }

  @override
  List<Object?> get props =>
      [id, idCabor, namaEvent, tanggalStart, tanggalEnd, expReg, status];
}
