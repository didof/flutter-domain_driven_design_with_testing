import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'package:DDD/domain/value_objects/Failure.dart';

class PublishDate extends Equatable {
  final String _value;

  PublishDate._(this._value);

  static Either<Failure, PublishDate> create(String value) {
    if (value == null) {
      return Left(Failure('PublishDate.value cannot be null'));
    }
    if (value.isEmpty) {
      return Left(Failure('PublishDate.value cannot be empty'));
    }
    final formatter = DateFormat('yyyy-MM-dd');
    try {
      formatter.parseStrict(value);
    } on FormatException {
      return Left(Failure('incorrect date format [yyyy-mm-dd]'));
    } catch (e) {
      return Left(Failure('[failure not known] $e'));
    }
    return Right(PublishDate._(value));
  }

  DateTime toDate() => DateTime.parse(_value);

  @override
  List<Object> get props => [_value];

  @override
  String toString() {
    return this._value;
  }
}
