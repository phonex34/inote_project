part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const EmailForm.pure(),
    this.password = const PasswordForm.pure(),
    this.status = FormzStatus.pure,
  });

  final EmailForm email;
  final PasswordForm password;
  final FormzStatus status;

  @override
  List<Object> get props => [email, password, status];

  LoginState copyWith({
    EmailForm email,
    PasswordForm password,
    FormzStatus status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
