import 'package:fpdart/fpdart.dart';
import '../error/failure.dart';

abstract interface class FutureUseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

// abstract interface class NormalUseCase<SuccessType, Params> {
//   Either<Failure, SuccessType> call(Params params);
// }

class NoParams {}
