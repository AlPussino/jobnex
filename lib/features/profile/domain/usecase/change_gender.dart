import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/profile/domain/repository/user_repository.dart';

class ChangeGender implements FutureUseCase<Null, ChangeGenderParams> {
  final UserRepository userRepository;
  const ChangeGender(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeGenderParams params) async {
    return await userRepository.changeGender(
      gender: params.gender,
    );
  }
}

class ChangeGenderParams {
  final String gender;
  const ChangeGenderParams({
    required this.gender,
  });
}
