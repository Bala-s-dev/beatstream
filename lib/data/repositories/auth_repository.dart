/// Thrown by [AuthRepository] implementations on login/registration failure.
class AuthException implements Exception {
  const AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}

abstract class AuthRepository {
  Future<void> login({required String email, required String password});

  Future<void> register({
    required String fullName,
    required String phone,
    required String email,
    required String password,
  });

  Future<void> logout();
}
