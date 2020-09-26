import 'package:DDD/domain/value_objects/Author.dart';
import 'package:DDD/domain/value_objects/ISBN.dart';
import 'package:DDD/domain/value_objects/Identity.dart';
import 'package:DDD/domain/value_objects/PublishDate.dart';
import 'package:DDD/domain/value_objects/Title.dart';

class Book {
  Identity shelfId;
  final Identity id;
  final Title title;
  final Author author;
  final ISBN isbn;
  final PublishDate publishDate;

  Book({
    this.id,
    this.shelfId,
    this.title,
    this.author,
    this.isbn,
    this.publishDate,
  });
}
