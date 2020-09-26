import 'package:DDD/domain/value_objects/Failure.dart';
import 'package:dartz/dartz.dart';

// signature
abstract class IUseCase<TUseCaseInput, TUseCaseOutput> {
  Future<Either<Failure, TUseCaseOutput>> execute(TUseCaseInput input);
}

// * here it's decided that any usecase must have the signature of any
// * usecase_input and any usecase_output.
// * The method [execute] takes any usecase_input and returns a Future whose
// * value is an Either, that can resolve to a Failure or to any usecase_output.
