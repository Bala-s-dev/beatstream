import 'package:equatable/equatable.dart';

enum SubmissionStatus { initial, submitting, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.status = SubmissionStatus.initial,
    this.errorMessage,
  });

  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final SubmissionStatus status;
  final String? errorMessage;

  bool get isValid => emailError == null && passwordError == null;

  LoginState copyWith({
    String? email,
    String? password,
    String? emailError,
    bool clearEmailError = false,
    String? passwordError,
    bool clearPasswordError = false,
    SubmissionStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: clearEmailError ? null : (emailError ?? this.emailError),
      passwordError: clearPasswordError
          ? null
          : (passwordError ?? this.passwordError),
      status: status ?? this.status,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    emailError,
    passwordError,
    status,
    errorMessage,
  ];
}
