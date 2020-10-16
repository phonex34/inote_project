part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const EmailForm.pure(),
    this.password = const PasswordForm.pure(),
    this.status = FormzStatus.pure,
  });

  final EmailForm email;
  final PasswordForm password;
  final FormzStatus status;

  @override
  List<Object> get props => [email, password, status];

  SignUpState copyWith({
    EmailForm email,
    PasswordForm password,
    FormzStatus status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
