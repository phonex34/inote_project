import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inote_project/modules/authentication/authentication.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
}
