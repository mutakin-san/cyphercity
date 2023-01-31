import 'package:equatable/equatable.dart';

class Cabor extends Equatable {
  final String id;
  final String namaCabor;
  final String gambar;

  const Cabor({required this.id, required this.namaCabor,required  this.gambar});


  factory Cabor.fromMap(Map<String, dynamic> map) {
    return Cabor(
      id: map['id'],
      namaCabor: map['nama_cabor'],
      gambar: map['gambar'],
    );
  }
  
  @override
  List<Object?> get props => [id, namaCabor, gambar];
}

