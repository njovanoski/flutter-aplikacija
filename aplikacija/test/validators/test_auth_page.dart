import 'package:aplikacija/pages/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main(List<String> args) {
  test('empty email returns error string', () {
    final result = EmailFieldValidator.validate('');
    expect(result, 'Please enter a valid email');
  });

  test('empty password returns error string', () {
    final result = PasswordFieldValidator.validate('');
    expect(result, 'Password invalid');
  });
  test('non-empty email returns null', () {
    final result = EmailFieldValidator.validate('email@email.com');
    expect(result, null);
  });
  test('non-empty password returns null', () {
    final result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });
}
