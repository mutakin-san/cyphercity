part of 'school_bloc.dart';

abstract class SchoolEvent extends Equatable {
  const SchoolEvent();

  @override
  List<Object> get props => [];
}

class LoadSchool extends SchoolEvent {
  final String id;

  const LoadSchool(this.id);


  @override
  List<Object> get props => [id];
}

class EditSchoolBiodata extends SchoolEvent {
  final String? kode;
  final String idUser;
  final String namaSekolah;
  final String npsn;
  final String biodata;
  final XFile? image;

  const EditSchoolBiodata({this.kode, required this.idUser, required this.namaSekolah, required this.npsn, required this.biodata, this.image});
}
