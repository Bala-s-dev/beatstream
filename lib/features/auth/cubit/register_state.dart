import 'package:equatable/equatable.dart';

import 'login_state.dart' show SubmissionStatus;

class RegisterState extends Equatable {
  const RegisterState({
    this.fullName = '',
    this.phone = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.fullNameError,
    this.phoneError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.status = SubmissionStatus.initial,
    this.errorMessage,
  });

  final String fullName;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;

  final String? fullNameError;
  final String? phoneError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  final SubmissionStatus status;
  final String? errorMessage;

  RegisterState copyWith({
    String? fullName,
    String? phone,
    String? email,
    String? password,
    String? confirmPassword,
    String? fullNameError,
    bool clearFullNameError = false,
    String? phoneError,
    bool clearPhoneError = false,
    String? emailError,
    bool clearEmailError = false,
    String? passwordError,
    bool clearPasswordError = false,
    String? confirmPasswordError,
    bool clearConfirmPasswordError = false,
    SubmissionStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      fullNameError: clearFullNameError
          ? null
          : (fullNameError ?? this.fullNameError),
      phoneError: clearPhoneError ? null : (phoneError ?? this.phoneError),
      emailError: clearEmailError ? null : (emailError ?? this.emailError),
      passwordError: clearPasswordError
          ? null
          : (passwordError ?? this.passwordError),
      confirmPasswordError: clearConfirmPasswordError
          ? null
          : (confirmPasswordError ?? this.confirmPasswordError),
      status: status ?? this.status,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    phone,
    email,
    password,
    confirmPassword,
    fullNameError,
    phoneError,
    emailError,
    passwordError,
    confirmPasswordError,
    status,
    errorMessage,
  ];
}
