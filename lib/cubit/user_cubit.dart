import 'package:bloc/bloc.dart';
import 'package:cyphercity/models/user.dart';
import 'package:cyphercity/services/login_pref_service.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());


  Future<void> loadUser() async {
    final user = await LoginPrefService.loginDetails;

    if(user != null ){
      emit(UserLoaded(user));
    } else {
      emit(const UserError('User not found'));
    }
  }
}
