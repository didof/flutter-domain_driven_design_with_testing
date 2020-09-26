// DTO - Data Transfer Object

import 'package:DDD/domain/value_objects/Author.dart';
import 'package:DDD/domain/value_objects/ISBN.dart';
import 'package:DDD/domain/value_objects/Identity.dart';
import 'package:DDD/domain/value_objects/PublishDate.dart';
import 'package:DDD/domain/value_objects/Title.dart';
import 'package:flutter/foundation.dart';

class AddBookInput {
  final Identity shelfId;
  final Title title;
  final Author author;
  final ISBN isbn;
  final PublishDate publishDate;

  AddBookInput({
    @required this.shelfId,
    @required this.title,
    @required this.author,
    @required this.isbn,
    @required this.publishDate,
  })  : assert(shelfId != null),
        assert(title != null),
        assert(author != null),
        assert(isbn != null),
        assert(publishDate != null);
}
