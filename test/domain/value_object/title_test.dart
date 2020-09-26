import 'package:DDD/domain/value_objects/Failure.dart';
import 'package:DDD/domain/value_objects/Title.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

void main() {
  group('Title', () {
    test('should return Failure when value is null', () {
      // arrange
      var title = Title.create(null).fold((l) => l, (r) => r);
      // assert
      expect(title, matcher.TypeMatcher<Failure>());
    });
    test('should return Failure when value is empty', () {
      // arrange
      var title = Title.create('').fold((l) => l, (r) => r);
      // assert
      expect(title, matcher.TypeMatcher<Failure>());
    });

    test('should create title when value is not empty', () {
      // arrange
      const str = 'foo';
      var title = Title.create(str).getOrElse(null);
      // assert
      expect(title.value, str);
    });
  });
}
