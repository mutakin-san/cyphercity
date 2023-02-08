part of 'school_bloc.dart';

abstract class SchoolEvent extends Equatable {
  const SchoolEvent();

  @override
  List<Object> get props => [];
}

class LoadSchool extends SchoolEvent {
  final String userId;

  const LoadSchool(this.userId);

  @override
  List<Object> get props => [userId];
}

class EditSchoolBiodata extends SchoolEvent {
  final String? kode;
  final String idUser;
  final String namaSekolah;
  final String npsn;
  final String biodata;
  final XFile? image;

  const EditSchoolBiodata(
      {this.kode,
      required this.idUser,
      required this.namaSekolah,
      required this.npsn,
      required this.biodata,
      this.image});
}

class EditSchoolLogo extends SchoolEvent {
  final String schoolId;
  final String userId;
  final XFile image;

  const EditSchoolLogo(this.schoolId, this.userId, this.image);
}
