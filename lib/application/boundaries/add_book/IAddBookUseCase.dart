import 'package:DDD/application/boundaries/IUseCase.dart';
import 'package:DDD/application/boundaries/add_book/add_book_input.dart';
import 'package:DDD/application/boundaries/add_book/add_book_output.dart';

// contract
abstract class IAddBookUsecase extends IUseCase<AddBookInput, AddBookOutput> {}
