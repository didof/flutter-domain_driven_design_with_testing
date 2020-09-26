import 'package:DDD/domain/value_objects/Failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final String value;
  Author._(this.value);

  static Either<Failure, Author> create(String value) {
    if (value == null) {
      return Left(Failure('Author.value cannot be null'));
    }
    if (value.isEmpty) {
      return Left(Failure('Author.value cannot be empty'));
    }
    return Right(Author._(value));
  }

  @override
  List<Object> get props => [value];
}
