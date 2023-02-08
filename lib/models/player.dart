class Player {
  final String id;
  final String idUser;
  final String idTim;
  final String namaPemain;
  final String tglLahir;
  final String nisn;
  final String posisi;
  final String noPunggung;
  final String foto;
  final String aktaLahir;
  final String kk;

  Player({
    required this.id,
    required this.idUser,
    required this.idTim,
    required this.namaPemain,
    required this.tglLahir,
    required this.nisn,
    required this.posisi,
    required this.noPunggung,
    required this.aktaLahir,
    required this.foto,
    required this.kk,
  });

  factory Player.fromMap(Map<String, dynamic> json) {
    return Player(
      id: "${json['id']}",
      idUser: json['id_user'],
      idTim: json['id_tim'],
      namaPemain: json['nama_pemain'],
      tglLahir: json['tgl_lahir'],
      nisn: json['nisn'],
      posisi: json['posisi'],
      noPunggung: json['no_punggung'],
      foto: json['foto'] ?? "",
      aktaLahir: json['akta_lahir'] ?? "",
      kk: json['kk'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'id_user': idUser,
      'id_tim': idTim,
      'nama_pemain': namaPemain,
      'tgl_lahir': tglLahir,
      'nisn': nisn,
      'posisi': posisi,
      'no_punggung': noPunggung,
      'foto': foto,
      'akta_lahir': aktaLahir,
      'kk': kk,
    };
  }
}
