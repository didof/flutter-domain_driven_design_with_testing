import 'package:DDD/domain/value_objects/Author.dart';
import 'package:DDD/domain/value_objects/Failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

void main() {
  group('Author', () {
    test('should return Failure when value is null', () {
      // arrange
      final author = Author.create(null).fold((l) => l, (r) => r);
      // assert
      expect(author, matcher.TypeMatcher<Failure>());
    });
    test('should return Failure when value is empty', () {
      // arrange
      final author = Author.create('').fold((l) => l, (r) => r);
      // assert
      expect(author, matcher.TypeMatcher<Failure>());
    });
    test('should create Author when value is not empty', () {
      // arrange
      const str = 'Stephen King';
      final author = Author.create(str).getOrElse(null);
      // assert
      expect(author.value, str);
    });
  });
}
