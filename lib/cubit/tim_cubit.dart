import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/tim.dart';
import '../services/api_services.dart';

part 'tim_state.dart';

class TimCubit extends Cubit<TimState> {
  TimCubit() : super(TimInitial());
  
  Future<void> loadTim(String idUser, String idSchool) async {
    final result =
        await ApiServices(http.Client()).getListTim(idUser: idUser, idSekolah: idSchool);

    debugPrint(result.toString());

    if (result.data != null) {
      emit(TimLoaded(result.data!));
    } else {
      emit(TimFailed(result.message ?? "Something error"));
    }
  }
}
