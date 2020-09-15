import 'package:aplikacija/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    final user = User(
      id: '1',
      email: 'user@example.com',
      token: 'abcdef0123456789',
    );

    test('toString contains props and classname', () {
      expect(
          user.toString(),
          stringContainsInOrder([
            '1',
            'user@example.com',
            'abcdef0123456789',
          ]));
    });
  });
}
