import 'package:aplikacija/pages/product_edit.dart';
import 'package:flutter_test/flutter_test.dart';

void main(List<String> args) {
  test('empty title returns error string', () {
    final result = BuildTitleTextValidator.validate('');
    expect(result, 'Title is required and should be 5+ characters long.');
  });
  test('non-empty title returns null', () {
    final result = BuildTitleTextValidator.validate('product');
    expect(result, null);
  });
  test(
    'empty dexcription returns error string',
    () {
      final result = BuildDescriptionTextValidator.validate('');
      expect(
          result, 'Description is required and should be 10 + character long');
    },
  );
  test(
    'non-empty dexcription returns error string',
    () {
      final result =
          BuildDescriptionTextValidator.validate('product description');
      expect(result, null);
    },
  );

  test(
    'empty price tag returns error string',
    () {
      final result = BuildPriceTextValidator.validate('');
      expect(result, 'Price is required and should be a number');
    },
  );

  test(
    'non-empty price tag returns error string',
    () {
      final result = BuildPriceTextValidator.validate('11');
      expect(result, null);
    },
  );
}
