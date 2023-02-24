import 'package:bloc/bloc.dart';
import 'package:cyphercity/core/network/network.dart';
import 'package:equatable/equatable.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutLoading()) {
    on<LoadAbout>((event, emit) async {
      emit(AboutLoading());

      final result = await AboutServices().getAboutText();

      if (result.data != null) {
        emit(AboutLoaded(result.data!));
      } else {
        emit(AboutFailed(result.message ?? "Something error!"));
      }
    });
  }
}
