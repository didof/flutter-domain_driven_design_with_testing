import 'package:DDD/domain/entities/Book.dart';
import 'package:DDD/domain/value_objects/Identity.dart';
import 'package:flutter/foundation.dart';

// # contract
abstract class IBookRepository {
  add(Book book);
  update(Book book);
  delete({@required Identity bookId});
  find({@required Identity bookId});
  findAll();
}
