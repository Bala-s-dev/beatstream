import 'auth_repository.dart';

/// Simulated auth backend. Any password of `password123` (or any password
/// for a not-yet-"registered" email) succeeds; a couple of fixed cases
/// are wired to fail so the error-handling UI path is exercisable.
class MockAuthRepository implements AuthRepository {
  final Duration _latency = const Duration(milliseconds: 900);

  @override
  Future<void> login({required String email, required String password}) async {
    await Future.delayed(_latency);
    if (email.toLowerCase() == 'blocked@beatstream.io') {
      throw const AuthException(
        'This account has been suspended. Contact support.',
      );
    }
    if (password.length < 6) {
      throw const AuthException('Incorrect email or password.');
    }
    // Success - a real implementation would persist a token here.
  }

  @override
  Future<void> register({
    required String fullName,
    required String phone,
    required String email,
    required String password,
  }) async {
    await Future.delayed(_latency);
    if (email.toLowerCase() == 'taken@beatstream.io') {
      throw const AuthException('An account with this email already exists.');
    }
    // Success.
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
