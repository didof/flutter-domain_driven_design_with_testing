import 'package:DDD/domain/entities/Book.dart';
import 'package:DDD/domain/entities/BookShelf.dart';
import 'package:DDD/domain/value_objects/Author.dart';
import 'package:DDD/domain/value_objects/ISBN.dart';
import 'package:DDD/domain/value_objects/PublishDate.dart';
import 'package:DDD/domain/value_objects/Title.dart';
import 'package:flutter/foundation.dart';

abstract class IEntityFactory {
  Book newBook({
    @required Title title,
    @required Author author,
    @required ISBN isbn,
    @required PublishDate publishDate,
  });

  BookShelf newBookShelf();
}
