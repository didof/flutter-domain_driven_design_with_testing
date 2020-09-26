import 'package:DDD/domain/value_objects/Failure.dart';
import 'package:DDD/domain/value_objects/PublishDate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

void main() {
  group('PublishDate', () {
    test('should return Failure when value is null', () {
      // arrange
      final publishDate = PublishDate.create(null).fold((l) => l, (r) => r);
      // assert
      expect(publishDate, matcher.TypeMatcher<Failure>());
    });
    test('should return Failure when value is empty', () {
      // arrange
      final publishDate = PublishDate.create('').fold((l) => l, (r) => r);
      // assert
      expect(publishDate, matcher.TypeMatcher<Failure>());
    });
    test(
        'should return Failure when value is not formatted properly [yyyy-MM-dd]',
        () {
      // arrange
      final publishDate =
          PublishDate.create('2019.01.20').fold((l) => l, (r) => r);
      // assert
      expect(publishDate, matcher.TypeMatcher<Failure>());
    });
    test(
        'should create PublishDate when value is formatted properly [yyyy-MM-dd]',
        () {
      // arrange
      const str = '1997-01-22';
      final publishDate = PublishDate.create(str).getOrElse(null);
      // assert
      expect(publishDate.toString(), str);
      expect(publishDate.toDate(), DateTime(1997, 01, 22));
    });
  });
}
