import 'package:beatstream/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators.email', () {
    test('rejects empty input', () {
      expect(Validators.email(''), isNotNull);
    });

    test('rejects malformed input', () {
      expect(Validators.email('not-an-email'), isNotNull);
    });

    test('accepts a valid address', () {
      expect(Validators.email('name@example.com'), isNull);
    });
  });

  group('Validators.password', () {
    test('rejects short passwords', () {
      expect(Validators.password('abc1'), isNotNull);
    });

    test('rejects letters-only passwords', () {
      expect(Validators.password('abcdefgh'), isNotNull);
    });

    test('accepts a mixed letters+digits password', () {
      expect(Validators.password('abcd1234'), isNull);
    });
  });

  group('Validators.confirmPassword', () {
    test('rejects a mismatch', () {
      expect(Validators.confirmPassword('abcd1234', 'abcd1235'), isNotNull);
    });

    test('accepts a match', () {
      expect(Validators.confirmPassword('abcd1234', 'abcd1234'), isNull);
    });
  });

  group('Validators.phone', () {
    test('rejects too-short numbers', () {
      expect(Validators.phone('123'), isNotNull);
    });

    test('accepts a formatted phone number', () {
      expect(Validators.phone('+1 (555) 000-0000'), isNull);
    });
  });

  group('Validators.fullName', () {
    test('rejects empty input', () {
      expect(Validators.fullName(''), isNotNull);
    });

    test('accepts a normal name', () {
      expect(Validators.fullName('John Doe'), isNull);
    });
  });
}
