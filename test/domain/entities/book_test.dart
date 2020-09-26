import 'package:DDD/domain/DomainException.dart';
import 'package:DDD/domain/entities/Book.dart';
import 'package:DDD/domain/entities/BookShelf.dart';
import 'package:DDD/domain/value_objects/Identity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

void main() {
  BookShelf sut;

  setUp(() {
    sut = BookShelf(id: Identity.fromString('abc'));
  });

  group('BookShelf', () {
    test(
        'addBook should throw a DomainException because the bookshelf already reached its capacity',
        () {
      // arrange
      for (int i = 0; i < 10; i++) {
        sut.addBook(Book());
      }
      // assert
      expect(() => sut.addBook(Book()),
          throwsA(matcher.TypeMatcher<DomainException>()));
    });
    test('addBook should add Book to shelf', () {
      // arrange
      final book = Book();
      // act
      sut.addBook(book);
      // assert
      expect(sut.books.length, 1);
    });
  });
}
