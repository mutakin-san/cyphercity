class RegEvent {
  RegEvent({
    required this.idReg,
    required this.idUser,
    required this.idSekolah,
    required this.idCabor,
    required this.idEvent,
    required this.idTim,
    required this.namaTeam,
    required this.namaEvent,
    required this.namaCabor,
    required this.tglReg,
    required this.jamReg,
    required this.buktiBayar,
    required this.status,
  });

  final String idReg;
  final String idUser;
  final String idSekolah;
  final String idCabor;
  final String idEvent;
  final String idTim;
  final String namaTeam;
  final String namaEvent;
  final String namaCabor;
  final DateTime tglReg;
  final String jamReg;
  final String buktiBayar;
  final String status;

  factory RegEvent.fromMap(Map<String, dynamic> json) => RegEvent(
        idReg: json["id_reg"],
        idUser: json["id_user"],
        idSekolah: json["id_sekolah"],
        idCabor: json["id_cabor"],
        idEvent: json["id_event"],
        idTim: json["id_tim"],
        namaTeam: json["nama_team"],
        namaEvent: json["nama_event"],
        namaCabor: json["nama_cabor"] ?? "",
        tglReg: DateTime.parse(json["tgl_reg"]),
        jamReg: json["jam_reg"],
        buktiBayar: json["bukti_bayar"],
        status: json["status"],
      );
}
