import 'package:DDD/domain/value_objects/Failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ISBN extends Equatable {
  static const extendedName = 'International Standard Book Number';

  final String value;
  ISBN._(this.value);

  static Either<Failure, ISBN> create(String value) {
    if (value == null) {
      return Left(Failure('ISBN.value cannot be null'));
    }
    if (value.isEmpty) {
      return Left(Failure('ISBN.value cannot be empty'));
    }
    if (!_isValid(value)) {
      return Left(Failure('ISBN.value is not a valid ISBN'));
    }
    return Right(ISBN._(value));
  }

  static bool _isValid(String value) {
    const regex =
        r'^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$';

    final exp = RegExp(regex);

    return exp.hasMatch(value);
  }

  @override
  List<Object> get props => [value];
}
