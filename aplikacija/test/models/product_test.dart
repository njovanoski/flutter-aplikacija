import 'package:aplikacija/models/location_data.dart';
import 'package:aplikacija/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product', () {
    final product = Product(
      id: '1',
      title: 'Apple',
      description: 'Delicious fruit',
      price: 2.1,
      image: 'apple.png',
      userEmail: 'user@example.com',
      userId: '1',
      location: LocationData(
        latitude: -50.0,
        longitude: 51,
        address: 'Elm Street 13',
      ),
      imagePath: 'fruits/',
      isFavorite: true,
    );

    test('toString contains props and classname', () {
      expect(
          product.toString(),
          stringContainsInOrder([
            '1',
            'Apple',
            'Delicious fruit',
            '2.1',
            'apple.png',
            'user@example.com',
            '1',
            'LocationData',
            'fruits/',
            'true',
          ]));
    });
  });
}
