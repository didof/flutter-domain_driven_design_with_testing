import 'package:DDD/domain/DomainException.dart';
import 'package:DDD/domain/entities/Book.dart';
import 'package:DDD/domain/entities/BookShelf.dart';
import 'package:DDD/domain/value_objects/Identity.dart';
import 'package:dartz/dartz.dart';
import 'package:DDD/application/boundaries/add_book/IAddBookUseCase.dart';
import 'package:DDD/application/boundaries/add_book/add_book_input.dart';
import 'package:DDD/application/boundaries/add_book/add_book_output.dart';
import 'package:DDD/domain/factories/IEntityFactory.dart';
import 'package:DDD/domain/repositories/IBookRepository.dart';
import 'package:DDD/domain/repositories/IBookShelfRepository.dart';
import 'package:DDD/domain/value_objects/Failure.dart';

class AddBookUseCase implements IAddBookUsecase {
  final IBookShelfRepository _bookShelfRepository;
  final IBookRepository _bookRepository;
  final IEntityFactory _entityFactory;
  AddBookUseCase({
    IBookShelfRepository bookShelfRepository,
    IBookRepository bookRepository,
    IEntityFactory entityFactory,
  })  : _bookShelfRepository = bookShelfRepository,
        _bookRepository = bookRepository,
        _entityFactory = entityFactory;

  @override
  Future<Either<Failure, AddBookOutput>> execute(AddBookInput input) async {
    final Book newBook = _createBookFromInput(input);

    final Either<Failure, BookShelf> result =
        await _addBookToShelf(newBook, input.shelfId);

    if (result.isLeft()) return result.fold((err) => Left(err), null);

    final BookShelf bookShelf = result.getOrElse(null);

    await _bookRepository.add(newBook);
    await _bookShelfRepository.update(bookShelf);
    return _buildAddBookOutput(newBook);
  }

  Book _createBookFromInput(AddBookInput input) {
    return _entityFactory.newBook(
      title: input.title,
      author: input.author,
      isbn: input.isbn,
      publishDate: input.publishDate,
    );
  }

  Future<Either<Failure, BookShelf>> _addBookToShelf(
    Book newBook,
    Identity shelfId,
  ) async {
    final BookShelf bookShelf = await _bookShelfRepository.find(shelfId);
    if (bookShelf == null) return Left(Failure('bookShelf not found'));
    try {
      bookShelf.addBook(newBook);
    } on DomainException {
      return Left(Failure('Book shelf has reached its maximum capacity'));
    }
    return Right(bookShelf);
  }

  Either<Failure, AddBookOutput> _buildAddBookOutput(Book newBook) {
    final output = AddBookOutput(
      shelfId: newBook.shelfId,
      bookId: newBook.id,
      title: newBook.title,
      author: newBook.author,
      isbn: newBook.isbn,
      publishDate: newBook.publishDate,
    );

    return Right(output);
  }
}
