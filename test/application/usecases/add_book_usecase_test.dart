import 'package:DDD/application/boundaries/add_book/add_book_input.dart';
import 'package:DDD/application/usecases/addBookUseCase.dart';
import 'package:DDD/domain/entities/Book.dart';
import 'package:DDD/domain/entities/BookShelf.dart';
import 'package:DDD/domain/factories/IEntityFactory.dart';
import 'package:DDD/domain/repositories/IBookRepository.dart';
import 'package:DDD/domain/repositories/IBookShelfRepository.dart';
import 'package:DDD/domain/value_objects/Author.dart';
import 'package:DDD/domain/value_objects/ISBN.dart';
import 'package:DDD/domain/value_objects/Identity.dart';
import 'package:DDD/domain/value_objects/PublishDate.dart';
import 'package:DDD/domain/value_objects/Title.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockShelfRepository extends Mock implements IBookShelfRepository {}

class MockBookRepository extends Mock implements IBookRepository {}

class MockEntityFactory extends Mock implements IEntityFactory {}

void main() {
  AddBookUseCase sut;
  MockShelfRepository mockShelfRepository;
  MockBookRepository mockBookRepository;
  MockEntityFactory mockEntityFactory;

  setUp(() {
    mockShelfRepository = MockShelfRepository();
    mockBookRepository = MockBookRepository();
    mockEntityFactory = MockEntityFactory();

    sut = AddBookUseCase(
      bookShelfRepository: mockShelfRepository,
      bookRepository: mockBookRepository,
      entityFactory: mockEntityFactory,
    );
  });

  group('AddBookUseCase', () {
    final title = Title.create('The Glory Game').getOrElse(null);
    final author = Author.create('Keith Laumer').getOrElse(null);
    final isbn = ISBN.create('ISBN-10: 0-596-52068-9').getOrElse(null);
    final publishDate = PublishDate.create('1975-06-22').getOrElse(null);

    final input = AddBookInput(
      shelfId: Identity.fromString('add'),
      title: title,
      author: author,
      isbn: isbn,
      publishDate: publishDate,
    );

    test('should return Failure when bookshelf does not exist', () async {
      // arrange
      when(mockShelfRepository.find(input.shelfId)).thenAnswer((_) => null);
      // act
      final result = await sut.execute(input);
      // assert
      expect(result.isLeft(), true);
    });

    test('should return book with created id when added successfully',
        () async {
      // arrange
      when(mockShelfRepository.find(input.shelfId)).thenAnswer((_) async {
        return BookShelf(id: input.shelfId);
      });
      when(mockEntityFactory.newBook(
        title: anyNamed('title'),
        author: anyNamed('author'),
        isbn: anyNamed('isbn'),
        publishDate: anyNamed('publishDate'),
      )).thenReturn(Book(
        id: Identity.fromString('bb'),
        title: title,
        author: author,
        isbn: isbn,
        publishDate: publishDate,
      ));

      // act
      final result = await sut.execute(input);

      // assert
      expect(result.isRight(), true);
      expect(result.getOrElse(null).bookId, isNotNull);
    });
  });
}
