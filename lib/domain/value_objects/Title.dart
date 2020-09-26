import 'package:DDD/domain/value_objects/Failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Title extends Equatable {
  final String value;
  const Title._(this.value);

  static Either<Failure, Title> create(String value) {
    if (value == null) {
      return Left(Failure('Title.value cannot be null'));
    }
    if (value.isEmpty) {
      return Left(Failure('Title.value cannot be empty'));
    }
    return Right(Title._(value));
  }

  @override
  List<Object> get props => [value];
}
