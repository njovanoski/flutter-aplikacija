import 'package:aplikacija/models/auth.dart';
import 'package:aplikacija/scoped-models/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart ' as http;

class MClient extends Mock implements http.Client {}

void main(List<String> args) {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('authenticate', () {
    test('Login returns successfully along with a successful authentication(?)',
        () async {
      final email = 'test1@test.com';
      final password = 'tester';

      expect(await MainModel().authenticate(email, password, AuthMode.Login),
          equals({'success': true, 'message': 'Authentication succeeded!'}));
    });
  });
}
