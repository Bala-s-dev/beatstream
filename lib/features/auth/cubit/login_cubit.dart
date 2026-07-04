import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/validators.dart';
import '../../../data/repositories/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const LoginState());

  final AuthRepository _authRepository;

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        clearEmailError: true,
        clearErrorMessage: true,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        clearPasswordError: true,
        clearErrorMessage: true,
      ),
    );
  }

  Future<void> submit() async {
    final String? emailError = Validators.email(state.email);
    final String? passwordError = Validators.loginPassword(state.password);

    emit(
      state.copyWith(
        emailError: emailError,
        clearEmailError: emailError == null,
        passwordError: passwordError,
        clearPasswordError: passwordError == null,
      ),
    );

    if (emailError != null || passwordError != null) return;

    emit(state.copyWith(status: SubmissionStatus.submitting));
    try {
      await _authRepository.login(email: state.email, password: state.password);
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
