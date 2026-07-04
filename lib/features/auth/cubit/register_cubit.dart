import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/validators.dart';
import '../../../data/repositories/auth_repository.dart';
import 'login_state.dart' show SubmissionStatus;
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const RegisterState());

  final AuthRepository _authRepository;

  void fullNameChanged(String value) => emit(
    state.copyWith(
      fullName: value,
      clearFullNameError: true,
      clearErrorMessage: true,
    ),
  );

  void phoneChanged(String value) => emit(
    state.copyWith(
      phone: value,
      clearPhoneError: true,
      clearErrorMessage: true,
    ),
  );

  void emailChanged(String value) => emit(
    state.copyWith(
      email: value,
      clearEmailError: true,
      clearErrorMessage: true,
    ),
  );

  void passwordChanged(String value) => emit(
    state.copyWith(
      password: value,
      clearPasswordError: true,
      // Re-validate confirm-password against the new password too.
      confirmPasswordError:
          state.confirmPassword.isNotEmpty &&
              state.confirmPassword != value
          ? 'Passwords do not match'
          : null,
      clearErrorMessage: true,
    ),
  );

  void confirmPasswordChanged(String value) => emit(
    state.copyWith(
      confirmPassword: value,
      clearConfirmPasswordError: true,
      clearErrorMessage: true,
    ),
  );

  Future<void> submit() async {
    final String? fullNameError = Validators.fullName(state.fullName);
    final String? phoneError = Validators.phone(state.phone);
    final String? emailError = Validators.email(state.email);
    final String? passwordError = Validators.password(state.password);
    final String? confirmPasswordError = Validators.confirmPassword(
      state.confirmPassword,
      state.password,
    );

    emit(
      state.copyWith(
        fullNameError: fullNameError,
        clearFullNameError: fullNameError == null,
        phoneError: phoneError,
        clearPhoneError: phoneError == null,
        emailError: emailError,
        clearEmailError: emailError == null,
        passwordError: passwordError,
        clearPasswordError: passwordError == null,
        confirmPasswordError: confirmPasswordError,
        clearConfirmPasswordError: confirmPasswordError == null,
      ),
    );

    if ([
      fullNameError,
      phoneError,
      emailError,
      passwordError,
      confirmPasswordError,
    ].any((e) => e != null)) {
      return;
    }

    emit(state.copyWith(status: SubmissionStatus.submitting));
    try {
      await _authRepository.register(
        fullName: state.fullName,
        phone: state.phone,
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: SubmissionStatus.success));
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          status: SubmissionStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: SubmissionStatus.failure,
          errorMessage: 'Something went wrong. Please try again.',
        ),
      );
    }
  }
}
