import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../core/repos/repositories.dart';
import '../models/school.dart';

part 'school_event.dart';
part 'school_state.dart';

class SchoolBloc extends Bloc<SchoolEvent, SchoolState> {

  final SchoolRepository _repository;


  SchoolBloc(this._repository) : super(SchoolInitial()) {


    on<LoadSchool>((event, emit) async {
      
      emit(SchoolLoading());

      final result =
          await _repository.getDetailSchool(event.id);

      if (result.data != null) {
        emit(SchoolLoaded(result.data!));
      } else {
        emit(SchoolFailed(result.message ?? "Something error"));
      }
    });

    on<EditSchoolBiodata>((event, emit) async {
      try {
        final result = await _repository.editBiodata(kode: event.kode, idUser: event.idUser, namaSekolah: event.namaSekolah, npsn: event.npsn, biodata: event.biodata, image: event.image);

        if(result) {
          add(LoadSchool(event.idUser));
        }
        
      } catch (e) {
        emit(SchoolFailed(e.toString()));
      }

    });
  }
}
