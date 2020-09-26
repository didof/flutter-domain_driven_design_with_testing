import 'package:DDD/domain/DomainException.dart';
import 'package:DDD/domain/entities/Book.dart';
import 'package:DDD/domain/value_objects/Identity.dart';
import 'package:flutter/foundation.dart';

class BookShelf {
  static const MAX_CAPACITY = 10;
  final Identity id;
  List<Book> _books;
  List<Book> get books => [..._books];

  BookShelf({
    @required this.id,
  }) {
    _books = List();
  }

  addBook(Book book) {
    if (_books.length == MAX_CAPACITY)
      throw DomainException('[BookShelf:$id] has reached maximum capacity');
    book.shelfId = id;
    _books.add(book);
  }
}
