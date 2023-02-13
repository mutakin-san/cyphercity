// To parse this JSON data, do
//
//     final regional = regionalFromMap(jsonString);

import 'dart:convert';

Regional regionalFromMap(String str) => Regional.fromMap(json.decode(str));

String regionalToMap(Regional data) => json.encode(data.toMap());

class Regional {
  Regional({
    required this.idRegion,
    required this.kode,
    required this.nama,
  });

  final String idRegion;
  final String kode;
  final String nama;

  factory Regional.fromMap(Map<String, dynamic> json) => Regional(
        idRegion: json["id_region"],
        kode: json["kode"],
        nama: json["nama"],
      );

  Map<String, dynamic> toMap() => {
        "id_region": idRegion,
        "kode": kode,
        "nama": nama,
      };
}

final dummyRegional = [
  regionalFromMap(
      jsonEncode("""{"id_region":"1","kode":"001","nama":"Ciamis"}""")),
  regionalFromMap(
      jsonEncode("""{"id_region":"2","kode":"002","nama":"Banjar"}""")),
];
