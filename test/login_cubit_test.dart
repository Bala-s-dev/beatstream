import 'package:beatstream/data/repositories/auth_repository.dart';
import 'package:beatstream/features/auth/cubit/login_cubit.dart';
import 'package:beatstream/features/auth/cubit/login_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
  });

  group('LoginCubit', () {
    test('initial state is empty and unsubmitted', () {
      final cubit = LoginCubit(authRepository: authRepository);
      expect(cubit.state, const LoginState());
      cubit.close();
    });

    blocTest<LoginCubit, LoginState>(
      'submit() emits a validation error when email is invalid',
      build: () => LoginCubit(authRepository: authRepository),
      act: (cubit) {
        cubit.emailChanged('not-an-email');
        cubit.passwordChanged('secret1');
        cubit.submit();
      },
      expect: () => [
        isA<LoginState>().having((s) => s.email, 'email', 'not-an-email'),
        isA<LoginState>().having(
          (s) => s.password,
          'password',
          'secret1',
        ),
        isA<LoginState>().having((s) => s.emailError, 'emailError', isNotNull),
      ],
      verify: (_) => verifyNever(
        () => authRepository.login(email: any(named: 'email'), password: any(named: 'password')),
      ),
    );

    blocTest<LoginCubit, LoginState>(
      'submit() succeeds for valid credentials',
      setUp: () {
        when(
          () => authRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async {});
      },
      build: () => LoginCubit(authRepository: authRepository),
      act: (cubit) {
        cubit.emailChanged('name@example.com');
        cubit.passwordChanged('secret1');
        cubit.submit();
      },
      skip: 2,
      expect: () => [
        isA<LoginState>().having(
          (s) => s.status,
          'status',
          SubmissionStatus.submitting,
        ),
        isA<LoginState>().having(
          (s) => s.status,
          'status',
          SubmissionStatus.success,
        ),
      ],
    );
  });
}
