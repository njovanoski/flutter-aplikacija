import 'package:aplikacija/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aplikacija/pages/product.dart';
import 'package:map_view/map_view.dart';

void main(List<String> args) {
  testWidgets('should show map from entered in product',
      (WidgetTester tester) async {
    final widget = MaterialApp(
      home: ProductPage(Product(
          id: null,
          title: null,
          description: null,
          price: null,
          image: null,
          userEmail: null,
          userId: null,
          location: null,
          imagePath: null)),
    );
    await tester.pumpWidget(widget);
    await tester.tap(find.byType(ProductPage));
    await tester.pumpAndSettle();
    expect(find.byType(MapView), findsOneWidget);
  });
}
