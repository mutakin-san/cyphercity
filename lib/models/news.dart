// To parse this JSON data, do
//
//     final news = newsFromMap(jsonString);

import 'dart:convert';

News newsFromMap(String str) => News.fromMap(json.decode(str));

String newsToMap(News data) => json.encode(data.toMap());

class News {
  News({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.gambar,
  });

  final String id;
  final String judul;
  final String deskripsi;
  final String gambar;

  factory News.fromMap(Map<String, dynamic> json) => News(
        id: json["id"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        gambar: json["gambar"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "judul": judul,
        "deskripsi": deskripsi,
        "gambar": gambar,
      };
}
