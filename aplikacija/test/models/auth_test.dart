import 'package:aplikacija/models/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AuthMode modes contains Login, Signup', () {
    final mode = AuthMode.values;
    expect(mode, containsAll([AuthMode.Login, AuthMode.Singup]));
  });
}
