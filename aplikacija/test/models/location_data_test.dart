import 'package:aplikacija/models/location_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocationData', () {
    final location = new LocationData(
      latitude: -50.0,
      longitude: 51,
      address: 'Elm Street 13',
    );

    test('new returns LocationData instance', () {
      expect(location.latitude, -50.0);
      expect(location.longitude, 51.0);
      expect(location.address, 'Elm Street 13');
    });

    test('toString contains props and classname', () {
      expect(
          location.toString(),
          stringContainsInOrder([
            'LocationData',
            '-50.0',
            '51.0',
            'Elm Street 13',
          ]));
    });
  });
}
