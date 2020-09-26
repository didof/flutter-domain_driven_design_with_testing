import 'package:DDD/domain/value_objects/Failure.dart';
import 'package:DDD/domain/value_objects/ISBN.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

void main() {
  group('ISBN', () {
    test('should return Failure when value is null', () {
      // arrange
      var isbn = ISBN.create(null).fold((l) => l, (r) => r);
      // assert
      expect(isbn, matcher.TypeMatcher<Failure>());
    });
    test('should return Failure when value is empty', () {
      // arrange
      var isbn = ISBN.create('').fold((l) => l, (r) => r);
      // assert
      expect(isbn, matcher.TypeMatcher<Failure>());
    });

    test('should return Failure when value is invalid', () {
      // arrange
      var isbn = ISBN.create('89990').fold((l) => l, (r) => r);
      // assert
      expect(isbn, matcher.TypeMatcher<Failure>());
    });

    test('should return ISBN when value is a valid isbn-10', () {
      // arrange
      const str = 'ISBN-10: 0-596-52068-9';
      var isbn = ISBN.create(str).getOrElse(null);
      // assert
      expect(isbn.value, str);
    });
    test('should return ISBN when value is a valid isbn-13', () {
      // arrange
      const str = 'ISBN-13: 978-0-596-52068-7';
      var isbn = ISBN.create(str).getOrElse(null);
      // assert
      expect(isbn.value, str);
    });
  });
}
