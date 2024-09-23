import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/profile/domain/repository/user_repository.dart';

class ChangeMobileNumber
    implements FutureUseCase<Null, ChangeMobileNumberParams> {
  final UserRepository userRepository;
  const ChangeMobileNumber(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeMobileNumberParams params) async {
    return await userRepository.changeMobileNumber(
      mobile_number: params.mobileNumber,
    );
  }
}

class ChangeMobileNumberParams {
  final String mobileNumber;
  const ChangeMobileNumberParams({
    required this.mobileNumber,
  });
}
