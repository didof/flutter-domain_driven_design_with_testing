import 'package:DDD/domain/entities/BookShelf.dart';
import 'package:DDD/domain/value_objects/Identity.dart';

// # contract
abstract class IBookShelfRepository {
  add(BookShelf bookShelf);
  update(BookShelf bookShelf);
  find(Identity shelfId);
}
