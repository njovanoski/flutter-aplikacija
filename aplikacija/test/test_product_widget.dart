import 'package:aplikacija/models/user.dart';
import 'package:aplikacija/scoped-models/connected_products.dart';
import 'package:flutter_test/flutter_test.dart';

void main(List<String> args) {
  testWidgets(
    'Testing widget in the product file',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        User(id: null, email: null, token: null),
      );
    },
  );
}
